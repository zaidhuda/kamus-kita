class BrowseController < ApplicationController
  def index
    @words = Word.select(:id, :word)
  end
end
