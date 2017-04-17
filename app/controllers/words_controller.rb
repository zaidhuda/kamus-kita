class WordsController < ApplicationController
  def index
    @words = Word.order(created_at: :desc).includes(best_definition: :user).page params[:page]
  end

  def show
    begin
      @word = Word.friendly.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      @word_not_found = true
      @word = Word.offset(rand(Word.count)).first
    end
    @definitions = @word.definitions.includes(:user).order(likes_counter: :desc, created_at: :desc).page params[:page]

    set_meta_tags title: @word.word,
                  description: @word.best_definition.definition.truncate(140)                  
  end
end
