class Product < ApplicationRecord
  belongs_to :category
  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_item
  validates :title, :description, :image_url, :quantity, :price, :category, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.1}

  private

    def ensure_not_referenced_by_any_line_item
      unless line_items.empty?
        errors.add(:base, 'Line Items present')
        throw :abort
      end
    end
end
