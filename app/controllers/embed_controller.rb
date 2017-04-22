class EmbedController < ApplicationController
  layout false, only: :show
  def show
    @definition = Definition.find(params[:id])

    set_meta_tags title: @definition.original_word,
      description: @definition.cleaned_definition.truncate(160),
      canonical: word_definition_url(@definition.word, @definition)

    response.headers.delete "X-Frame-Options"
  end

  def embed_settings
    url = Rails.application.routes.recognize_path(params[:url])
    case url[:controller]
    when 'words'
      @word = Word.includes(:best_definition).friendly.find(url[:id])
      @definition = @word.best_definition
    when 'definitions'
      @word = Word.friendly.find(url[:word_id])
      @definition = Definition.find(url[:id])
    end
    @iframe_code = "<iframe src='#{embed_word_definition_url(@word, @definition)}' width='#{params[:width]}' height='307.8' style='border:none;overflow:hidden' scrolling='no' frameborder='0' allowTransparency='true'></iframe>"
  rescue ActiveRecord::RecordNotFound, ActionController::RoutingError
  end
end
