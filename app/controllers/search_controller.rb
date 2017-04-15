class SearchController < ApplicationController
  def index
    @words = Word.where("word LIKE ?", "#{params[:q]}%")
    @random_word = Word.find(rand(Word.ids.min..Word.ids.max))
  end
end
