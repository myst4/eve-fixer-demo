# A promo coupon a customer can apply to their cart.
class Coupon
  def initialize(attributes)
    @attributes = attributes
  end

  def code
    attributes[:code]
  end

  # Coupons without an expiry never expire.
  def expired?
    attributes[:expires_at].past?
  end

  private

  attr_reader :attributes
end
