require "test_helper"

class ShippingLabelTest < ActiveSupport::TestCase
  test "builds the address block" do
    address = { street: "Av. Corrientes", number: "1234", city: "CABA", postal_code: "c1043" }
    assert_equal ["AV. CORRIENTES 1234", "CABA, C1043"], ShippingLabel.new(address).lines
  end
end
