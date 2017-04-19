class RandomController < ApplicationController
  def index
    random_word = Word.offset(rand(Word.count)).first
    redirect_to word_path(random_word)
  end
end
