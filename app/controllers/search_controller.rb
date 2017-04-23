class SearchController < ApplicationController
  def index
    @definitions = Definition
                    .includes(:user, :word)
                    .where("original_word ILIKE ?", "#{params[:q]}%")
                    .order(likes_counter: :desc, created_at: :desc)
                    .page params[:page]
    # @random_word = Word.offset(rand(Word.count)).first

    set_meta_tags title: 'Search',
                  description: 'Search words'
  end
end
