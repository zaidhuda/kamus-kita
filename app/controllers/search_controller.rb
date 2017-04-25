class SearchController < ApplicationController
  def index
    @definitions = Definition.search_for(params[:q]).page(params[:page])

    set_meta_tags title: 'Search',
                  description: 'Search words'
  end
end
