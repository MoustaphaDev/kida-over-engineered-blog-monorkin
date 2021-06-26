# frozen_string_literal: true

# == Schema Information
# Schema version: 20210125065024
#
# Table name: tags
#
#  id         :uuid             not null, primary key
#  name       :citext
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_tags_on_name  (name) UNIQUE
#
class Tag < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
