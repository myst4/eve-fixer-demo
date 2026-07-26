# Calculates what a customer owes for an order.
class OrderTotal
  FREE_SHIPPING_THRESHOLD = 5000

  def initialize(line_items, shipping_cost: 500)
    @line_items = line_items
    @shipping_cost = shipping_cost
  end

  def call
    subtotal + shipping
  end

  private

  attr_reader :line_items, :shipping_cost

  def subtotal
    line_items.sum { |item| item[:price] * item[:quantity] }
  end

  def shipping
    subtotal >= FREE_SHIPPING_THRESHOLD ? 0 : shipping_cost
  end
end
