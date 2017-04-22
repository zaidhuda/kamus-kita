class ImageController < ApplicationController
  layout false

  def show    
    @definition = Definition.find(params[:id])
    @definition.generate_image_helper "#{request.protocol}#{request.host}"
    image = open(@definition.image.url)
    send_data image.read, filename: "#{@definition.original_word}.png", type: image.content_type, disposition: 'inline',  stream: 'true', buffer_size: '4096'
  rescue OpenURI::HTTPError
    @definition.generate_image "#{request.protocol}#{request.host}"
    logo
  ensure
    response.headers["Cache-Control"] = "no-cache, no-store"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  def new
    @definition = Definition.find(params[:id])
    render_to_string 'image/new'
  end

  private

  def logo
    image = open(Rails.root.join("public/logo-large.png"))
    send_data image.read, filename: "logo-large.png", disposition: 'inline',  stream: 'true', buffer_size: '4096'
  end
end
