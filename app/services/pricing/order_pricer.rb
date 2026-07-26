module Pricing
  # Computes what a customer is charged, in their own currency.
  class OrderPricer
    def initialize(order, display_currency:)
      @order = order
      @display_currency = display_currency
    end

    def total_cents
      converter.convert(subtotal_cents + shipping_cents + tax_cents)
    end

    def breakdown
      {
        subtotal: converter.convert(subtotal_cents),
        shipping: converter.convert(shipping_cents),
        tax: converter.convert(tax_cents),
        total: total_cents,
      }
    end

    private

    attr_reader :order, :display_currency

    def converter
      CurrencyConverter.new(from: order[:currency], to: display_currency)
    end

    def subtotal_cents
      order[:line_items].sum { |item| item[:price_cents] * item[:quantity] }
    end

    def shipping_cents
      order[:shipping_cents]
    end

    def tax_cents
      ((subtotal_cents + shipping_cents) * order[:tax_rate]).round
    end
  end
end
