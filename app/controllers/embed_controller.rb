class EmbedController < ApplicationController
  layout false, only: :show
  def show
    @word = Word.includes(:best_definition).friendly.find(params[:id])
    @definition = @word.best_definition

    set_meta_tags title: @word.word,
                  description: @word.best_definition.definition.truncate(160),
                  canonical: word_url(@word)

    response.headers.delete "X-Frame-Options"
  end

  def embed_test
    @word = Word.includes(:best_definition).friendly.find(params[:id])
  end
end
