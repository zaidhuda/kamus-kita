class ImageController < ApplicationController
  layout false

  def full_image
    @definition = Definition.find(params[:id])
    open_image open(@definition.image.url), "#{@definition.original_word.downcase.parameterize}-definition"
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
    @word = Word.friendly.find(params[:id])
    open_image open(@word.banner.url), "#{@word.word}-banner"
  rescue OpenURI::HTTPError, Errno::ENOENT
    if @word.run_banner_generator_job
      logo
    end
  end

  def banner
    @definition = Word.friendly.find(params[:id])
    render_to_string 'image/full'
  end

  private

  def open_image image, filename
    send_data image.read, filename: "#{filename}.png", type: image.content_type, disposition: 'inline',  stream: 'true', buffer_size: '4096'
  end

  def logo
    image = open(Rails.root.join("public/logo-small.png"))
    send_data image.read, filename: "logo-large.png", disposition: 'inline',  stream: 'true', buffer_size: '4096'
  end
end
