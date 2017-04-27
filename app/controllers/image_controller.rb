class ImageController < ApplicationController
  layout false

  def show    
    @definition = Definition.find(params[:id])
    image = open(@definition.image.url)
    send_data image.read, filename: "#{@definition.original_word}.png", type: image.content_type, disposition: 'inline',  stream: 'true', buffer_size: '4096'
  rescue OpenURI::HTTPError, Errno::ENOENT
    if @definition.run_image_generator_job
      render plain: 'Image not ready. Try again later.'
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
