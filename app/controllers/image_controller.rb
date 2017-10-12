class ImageController < ApplicationController
  layout false

  def image
    @definition = Definition.find(params[:id])
    @definition.run_image_generator_job if @definition.image.file.nil?
    open_image open(@definition.image.url), "#{@definition.original_word.downcase.parameterize}-definition"
  rescue OpenURI::HTTPError, Errno::ENOENT
    render template: 'image/full'
  end

  def image_template
    @definition = Definition.find(params[:id])
    render template: 'image/full'
  end

  def banner
    @word = Word.friendly.find(params[:id])
    @word.run_banner_generator_job if @word.banner.file.nil?
    open_image open(@word.banner.url), "#{@word.word}-banner"
  rescue OpenURI::HTTPError, Errno::ENOENT
    render template: 'image/banner'
  end

  def banner_template
    @word = Word.friendly.find(params[:id])
    render template: 'image/banner'
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
