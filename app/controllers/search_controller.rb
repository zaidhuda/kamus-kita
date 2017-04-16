class SearchController < ApplicationController
  def index
    @words = Word.where("word LIKE ?", "#{params[:q]}%").page params[:page]
    @random_word = Word.offset(rand(Word.count)).first

    set_meta_tags title: 'Search',
                  description: 'Search words'
  end
end
