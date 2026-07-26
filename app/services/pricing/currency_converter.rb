module Pricing
  # Converts an amount between currencies for display and for charging.
  #
  # Rates come from the `exchange_rates` table, refreshed nightly.
  class CurrencyConverter
    class MissingRate < StandardError; end

    def initialize(from:, to:)
      @from = from
      @to = to
    end

    def convert(cents)
      (cents * rate).round
    end

    private

    attr_reader :from, :to

    def rate
      row = ExchangeRate.find_by(base: from, quote: to)
      row.multiplier
    end
  end
end
