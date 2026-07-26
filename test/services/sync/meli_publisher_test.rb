require "test_helper"

class Sync::MeliPublisherTest < ActiveSupport::TestCase
  test "builds the payload from the listing" do
    listing = { title: "Zapatilla", price_cents: 45_900, currency: "ARS", stock: 3 }
    publisher = Sync::MeliPublisher.new(listing)
    assert_equal "Zapatilla", publisher.send(:payload)[:title]
    assert_equal 459.0, publisher.send(:payload)[:price]
  end
end
