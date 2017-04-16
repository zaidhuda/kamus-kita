class WordsController < ApplicationController
  def index
    @words = Word.order(created_at: :desc).includes(best_definition: :user).page params[:page]
  end

  def show
    @word = Word.friendly.find(params[:id])
    @definitions = @word.definitions.includes(:user).order(likes_counter: :desc, created_at: :desc).page params[:page]
  end
end
