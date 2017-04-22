class ImageController < ApplicationController
  layout false

  def show    
    @definition = Definition.find(params[:id])
    @definition.generate_image_helper "#{request.protocol}#{request.host}"
    image = open(@definition.image.url)
    send_data image.read, filename: "#{@definition.original_word}.png", type: image.content_type, disposition: 'inline',  stream: 'true', buffer_size: '4096'
  rescue OpenURI::HTTPError
    if @definition.generate_image "#{request.protocol}#{request.host}"
      redirect_to image_word_definition_path(params[:word_id], params[:id])
    else
      logo
    end
  end

  def new
    @definition = Definition.find(params[:id])
    render_to_string 'image/new'
  end

  private

  def logo
    image = open(Rails.root.join("public/logo-small.png"))
    send_data image.read, filename: "logo-large.png", disposition: 'inline',  stream: 'true', buffer_size: '4096'
  end
end
