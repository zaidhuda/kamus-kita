class ImageController < ApplicationController
  layout false

  def full_image
    @definition = Definition.find(params[:id])
    open_image open(@definition.image.url), 'full-image'
  rescue OpenURI::HTTPError, Errno::ENOENT
    if @definition.run_image_generator_job
      return render plain: 'Image not ready. Try again later.'
    else
      logo
    end
  end

  def full
    @definition = Definition.find(params[:id])
    render_to_string 'image/full'
  end

  def banner_image
    @definition = Definition.find(params[:id])
    open_image open(@definition.banner.url), 'banner'
  rescue OpenURI::HTTPError, Errno::ENOENT
    if @definition.run_banner_generator_job
      render plain: 'Image not ready. Try again later.'
    else
      logo
    end
  end

  def banner
    @definition = Definition.find(params[:id])
    render_to_string 'image/full'
  end

  private

  def open_image image, type
    send_data image.read, filename: "#{@definition.original_word.downcase.parameterize}-#{type}.png", type: image.content_type, disposition: 'inline',  stream: 'true', buffer_size: '4096'
  end

  def logo
    image = open(Rails.root.join("public/logo-small.png"))
    send_data image.read, filename: "logo-large.png", disposition: 'inline',  stream: 'true', buffer_size: '4096'
  end
end
