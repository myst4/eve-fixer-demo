require "test_helper"

class CustomerNameTest < ActiveSupport::TestCase
  test "formats the full name" do
    customer = { first_name: "Ada", last_name: "Lovelace" }
    assert_equal "Ada Lovelace", CustomerName.new(customer).full
  end

  test "formats the short name" do
    customer = { first_name: "Ada", last_name: "Lovelace" }
    assert_equal "A. Lovelace", CustomerName.new(customer).short
  end

  test "trims surrounding whitespace in the last name" do
    customer = { first_name: "Ada", last_name: "  Lovelace  " }
    assert_equal "Ada Lovelace", CustomerName.new(customer).full
  end
end
