class SearchController < ApplicationController
  def index
    @words = Word.where("word LIKE ?", "#{params[:q]}%").page params[:page]
    @random_word = Word.offset(rand(Word.count)).first
  end
end
