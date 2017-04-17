class SitemapController < ApplicationController
  def index
    render xml: Zlib::GzipReader.new(open("#{Rails.public_path}/sitemap.xml.gz"))
  end
end
