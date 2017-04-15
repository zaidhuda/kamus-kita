class WordsController < ApplicationController
  def index
    @words = Word.all.page params[:page]
  end

  def show
    @word = Word.friendly.find(params[:id])
  end
end
