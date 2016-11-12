require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products
  test "product attributes must not be emppty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:quantity].any?
    assert product.errors[:image_url].any?
  end

  test "product price must be positive" do
    product = Product.new(title:      "Product title",
                          description:"Description",
                          quantity:   5,
                          image_url:  "image.png")
    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.1"],
      product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.1"],
      product.errors[:price]

    product.price = 1
    assert product.valid?
  end
end
