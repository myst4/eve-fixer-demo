require "test_helper"

class OrderTotalTest < ActiveSupport::TestCase
  test "sums line items and adds shipping" do
    items = [{ price: 1000, quantity: 2 }, { price: 500, quantity: 1 }]
    assert_equal 3000, OrderTotal.new(items).call
  end

  test "shipping is free above the threshold" do
    items = [{ price: 3000, quantity: 2 }]
    assert_equal 6000, OrderTotal.new(items).call
  end
end
