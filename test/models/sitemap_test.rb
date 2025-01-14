# frozen_string_literal: true

require 'test_helper'

class SitemapTest < ActiveSupport::TestCase
  include Rails.application.routes.url_helpers

  test '#to_xml generates a sitemap' do
    5.times do |i|
      Article.create!(title: "#{Faker::Book.title} (#{i})",
                      content: Faker::Markdown.sandwich(sentences: 50),
                      publish_at: i.days.ago,
                      published: true)
    end

    sitemap = Sitemap.new(scope: Article.all)
    hash = Hash.from_xml(sitemap.to_xml)

    actual_urls = hash.dig('urlset', 'url').map { |site| site['loc'] }

    expected_urls = sitemap.scope.map { |article| article_url(article) }
    expected_urls << root_url.sub(/\/$/, '')

    assert_equal(expected_urls.sort, actual_urls.sort)
  end
end
