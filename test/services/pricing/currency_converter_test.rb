require "test_helper"

module Pricing
  class CurrencyConverterTest < ActiveSupport::TestCase
    test "converts using the stored multiplier" do
      with_rate(Struct.new(:multiplier).new(1.5)) do
        assert_equal 1_500, CurrencyConverter.new(from: "EUR", to: "USD").convert(1_000)
      end
    end

    test "raises MissingRate when there is no row for the pair" do
      with_rate(nil) do
        error = assert_raises(CurrencyConverter::MissingRate) do
          CurrencyConverter.new(from: "EUR", to: "USD").convert(1_000)
        end
        assert_match "EUR", error.message
        assert_match "USD", error.message
      end
    end

    test "converting to the same currency does not need a stored rate" do
      with_rate(nil) do
        assert_equal 1_000, CurrencyConverter.new(from: "EUR", to: "EUR").convert(1_000)
      end
    end

    private

    # `minitest/mock` is not bundled with Minitest 6, so the lookup is replaced
    # by hand and restored afterwards.
    def with_rate(row)
      singleton = ExchangeRate.singleton_class
      original = ExchangeRate.method(:find_by)
      singleton.define_method(:find_by) { |*, **| row }
      yield
    ensure
      singleton.define_method(:find_by, original)
    end
  end
end
