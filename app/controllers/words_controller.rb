class WordsController < ApplicationController
  def index
    @words = Word.order(created_at: :desc).includes(best_definition: :user).page params[:page]
  end

  def show
    @word = Word.includes(:best_definition).friendly.find(params[:id].parameterize)

    set_meta_tags title: @word.word,
      canonical: word_url(params[:id]),
      description: @word.best_definition.cleaned_definition.truncate(160),
      image: banner_word_url(params[:id], format: :png),
      og: { image: banner_word_url(params[:id], format: :png) },
      twitter: {image: { _: banner_word_url(params[:id], format: :png) }}

    @definitions = Definition.where(word_id: @word.id)
                    .includes(:user, :word)
                    .order(likes_counter: :desc, created_at: :desc)
                    .page params[:page]
  rescue ActiveRecord::RecordNotFound
    @word_not_found = true
    # @word = Word.includes(:best_definition).offset(rand(Word.count)).first

    set_meta_tags title: params[:id],
      canonical: new_definition_url(word: params[:id]),
      description: "There is no definition for #{params[:id]}. Submit yours?",
      noindex: true
  end
end
