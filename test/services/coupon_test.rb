require "test_helper"

class CouponTest < ActiveSupport::TestCase
  test "an old coupon is expired" do
    assert Coupon.new(code: "X", expires_at: 1.day.ago).expired?
  end
end
