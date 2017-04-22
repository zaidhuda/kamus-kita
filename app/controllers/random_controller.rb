class RandomController < ApplicationController
  def index
    response.headers["Cache-Control"] = "no-cache, no-store"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
    
    @word = Word.offset(rand(Word.count)).first
    @definitions = Definition
                    .includes(:user, :word)
                    .where(word_id: @word.id)
                    .order(likes_counter: :desc, created_at: :desc)
                    .page params[:page]

    set_meta_tags title: 'Random word',
                  description: 'Find random word.'

    render template: 'words/show'
  end
end
