require "test_helper"

class DiscountCodeTest < ActiveSupport::TestCase
  test "normalises a code" do
    assert_equal "VERANO26", DiscountCode.new("  verano26 ").normalized
  end

  test "rejects a code that is too short" do
    assert_not DiscountCode.new("ab").valid?
  end
end
