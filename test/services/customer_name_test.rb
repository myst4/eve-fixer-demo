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

  test "usa solo el nombre cuando el apellido es nil" do
    customer = { first_name: "Ada", last_name: nil }
    assert_equal "Ada", CustomerName.new(customer).full
  end

  test "usa solo el nombre cuando la clave del apellido no viene" do
    customer = { first_name: "Ada" }
    assert_equal "Ada", CustomerName.new(customer).full
  end

  test "el nombre corto no falla cuando el apellido es nil" do
    customer = { first_name: "Ada", last_name: nil }
    assert_equal "A.", CustomerName.new(customer).short
  end
end
