class WordsController < ApplicationController
  def index
    @words = Word.all.eager_load(:definitions).page params[:page]
  end

  def show
    @word = Word.friendly.find(params[:id])
    @definitions = @word.definitions.includes(:user).order(likes_counter: :desc, created_at: :desc).page params[:page]
  end
end
