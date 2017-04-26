require 'rubygems'
require 'sitemap_generator'

SitemapGenerator::Sitemap.default_host = ENV['HOST_NAME']
SitemapGenerator::Sitemap.sitemaps_host = ENV['AWS_REMOTE_HOST']
SitemapGenerator::Sitemap.public_path = 'tmp/'
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'
SitemapGenerator::Sitemap.adapter = SitemapGenerator::WaveAdapter.new

SitemapGenerator::Sitemap.create do
  add search_path
  add browse_path
  add vote_path
  add privacy_path
  Word.find_each do |word|
    add word_path(word), lastmod: word.best_definition.created_at
  end
  # add tos_path
  # add help_path
end
# SitemapGenerator::Sitemap.ping_search_engines # Not needed if you use the rake tasks