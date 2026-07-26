require "test_helper"

class InvoiceNumberTest < ActiveSupport::TestCase
  test "formats the invoice number" do
    order = { placed_at: Time.utc(2026, 4, 12), sequence: 412 }
    assert_equal "INV-2026-0412", InvoiceNumber.new(order).formatted
  end
end
