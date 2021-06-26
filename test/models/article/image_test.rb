# == Schema Information
# Schema version: 20210125065024
#
# Table name: article_images
#
#  id            :uuid             not null, primary key
#  image_data    :jsonb
#  original_path :text
#  primary       :boolean          default(FALSE), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  article_id    :string           not null
#
# Indexes
#
#  index_article_images_on_article_id              (article_id)
#  index_article_images_on_article_id_and_primary  (article_id,primary) UNIQUE WHERE ("primary" = true)
#  index_article_images_on_primary                 (primary)
#
# Foreign Keys
#
#  fk_rails_...  (article_id => articles.id)
#
require 'test_helper'

class Article::ImageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
