class BrowseController < ApplicationController
  def index
    @words = Word.select(:id, :word, :slug).order(:slug)
  end
end
