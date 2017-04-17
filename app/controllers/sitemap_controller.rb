class SitemapController < ApplicationController
  def index
    urls = []
    urls << url_hash(root_url, Time.now, 'always', 1.0)
    urls << url_hash(browse_url)
    urls << url_hash(search_url)
    urls << url_hash(new_user_registration_url)
    Word.find_each do |word|
      urls << url_hash(word_url(word), word.updated_at)
    end
    render xml: urls.to_xml(root: :urlset)
    # render xml: Zlib::GzipReader.new(open("#{Rails.public_path}/sitemap.xml.gz"))
  end

  def url_hash loc=root_url, lastmod=Time.now, changefreq='weekly', priority=0.5
    {
      student: {
        loc: loc,
        lastmod: lastmod,
        changefreq: changefreq,
        priority: priority,
      }
    }
  end
end
