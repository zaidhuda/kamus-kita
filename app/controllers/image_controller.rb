class ImageController < ApplicationController
  layout false
  def show
    @definition = Definition.find(params[:id])
    @definition.generate_image_helper "#{request.protocol}#{request.host}"
    redirect_to @definition.image.url
  end

  def new
    @definition = Definition.find(params[:id])
    render_to_string 'image/new'
  end
end
