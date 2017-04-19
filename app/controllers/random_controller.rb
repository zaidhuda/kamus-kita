class RandomController < ApplicationController
  def index
    @word = Word.offset(rand(Word.count)).first
    @definitions = Definition
                    .includes(:user, :word)
                    .where(word_id: @word.id)
                    .order(likes_counter: :desc, created_at: :desc)
                    .page params[:page]
    render template: 'words/show'
  end
end
