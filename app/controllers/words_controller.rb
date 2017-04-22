class WordsController < ApplicationController
  def index
    @words = Word.order(created_at: :desc).includes(best_definition: :user).page params[:page]
  end

  def show
    begin
      @word = Word.includes(:best_definition).friendly.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      @word_not_found = true
      @word = Word.includes(:best_definition).offset(rand(Word.count)).first
    end
    @definitions = Definition.where(word_id: @word.id)
                    .includes(:user, :word)
                    .order(likes_counter: :desc, created_at: :desc)
                    .page params[:page]

    set_meta_tags title: @word.word,
      description: @word.best_definition.cleaned_definition.truncate(160),
      image: image_word_definition_url(params[:id], @word.best_definition, format: :png),
      og: {
        image: image_word_definition_url(params[:id], @word.best_definition, format: :png)
      },
      twitter: {
        image: {
          _: image_word_definition_url(params[:id], @word.best_definition, format: :png)
        }
      }
  end
end
