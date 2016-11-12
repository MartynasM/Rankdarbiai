class Order < ApplicationRecord
  enum city: {
    "Vilnius"     => 0,
    "Kaunas"      => 1,
    "Klaipėda"    => 2,
    "Panevėžys"   => 3
  }

  has_many :line_items, dependent: :destroy
  validates :first_name, :last_name, :email, :adress, :number, presence: true
  validates :city, inclusion: cities.keys

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
end
