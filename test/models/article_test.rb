# == Schema Information
# Schema version: 20210627083831
#
# Table name: articles
#
#  id           :string           not null, primary key
#  content      :text             default(""), not null
#  publish_at   :datetime
#  published    :boolean          default(FALSE), not null
#  published_at :datetime
#  slug         :text             default(""), not null
#  thread       :string
#  title        :text             default(""), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_articles_on_published_at  (published_at)
#  index_articles_on_thread        (thread)
#
require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end