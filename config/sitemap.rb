require 'rubygems'
require 'sitemap_generator'

SitemapGenerator::Sitemap.default_host = 'https://kamuskita.zaidhuda.com'
SitemapGenerator::Sitemap.create do
  add browse_path
  add search_path
  add new_user_registration_path
  Word.find_each do |word|
    add word_path(word), lastmod: word.updated_at
  end
end
# SitemapGenerator::Sitemap.ping_search_engines # Not needed if you use the rake tasks