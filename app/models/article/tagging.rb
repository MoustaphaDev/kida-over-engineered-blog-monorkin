# frozen_string_literal: true

# == Schema Information
# Schema version: 20210125065024
#
# Table name: article_taggings
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :string           not null
#  tag_id     :uuid             not null
#
# Indexes
#
#  index_article_taggings_on_article_id             (article_id)
#  index_article_taggings_on_article_id_and_tag_id  (article_id,tag_id) UNIQUE
#  index_article_taggings_on_tag_id                 (tag_id)
#
# Foreign Keys
#
#  fk_rails_...  (article_id => articles.id)
#  fk_rails_...  (tag_id => tags.id)
#
class Article
  class Tagging < ApplicationRecord
    belongs_to :article
    belongs_to :tag

    validates :article,
              presence: true
    validates :tag,
              presence: true,
              uniqueness: { scope: :article }
  end
end
