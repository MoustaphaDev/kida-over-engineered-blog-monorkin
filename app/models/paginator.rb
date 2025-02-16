# frozen_string_literal: true

class Paginator
  include ActiveModel::Model
  include ActiveModel::Attributes

  DEFAULT_PAGE_SIZES = [6, 12, 20, 32].freeze
  MAX_PAGE_SIZE = DEFAULT_PAGE_SIZES.last

  attr_accessor :scope,
                :direction,
                :page_sizes,
                :cursor

  attribute :record_id, :string
  attribute :page, :integer, default: 1
  attribute :max_page_size, :integer, default: MAX_PAGE_SIZE

  validates :record_id,
            presence: true
  validates :page,
            presence: true
  validates :scope,
            presence: true

  def self.decode(scope:, cursor:, direction:)
    page, record_id = cursor&.split('-', 2)

    new(
      page: page,
      record_id: record_id,
      scope: scope,
      direction: direction
    )
  end

  def next
    return unless next_page_exists?

    "#{page + 1}-#{records.last&.id}"
  end

  def next_page_exists?
    records.count == page_size
  end

  def previous
    return unless previous_page_exists?

    "#{page - 1}-#{(records.first || record)&.id}"
  end

  def previous_page_exists?
    page > 1
  end

  def page
    return 1 if super.nil? || super < 1

    super
  end

  def page_size
    page_sizes.at(page - 1) || max_page_size
  end

  def page_sizes
    @page_sizes.presence || DEFAULT_PAGE_SIZES
  end

  def records
    if direction == :after
      after&.first(page_size) || scope.limit(page_size)
    else
      before&.first(page_size)&.reverse || scope.none
    end.to_a
  end

  def direction
    return :before if @direction.presence&.to_sym == :before

    :after
  end

  def before
    nexter&.before
  end

  def after
    nexter&.after
  end

  private

  def nexter
    return unless record

    @nexter ||= Nexter.wrap(scope, record)
  end

  def record
    @record ||= scope.model.find_by(id: record_id)
  end
end
