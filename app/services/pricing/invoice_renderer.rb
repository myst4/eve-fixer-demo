module Pricing
  # Renders the amounts printed on an invoice PDF.
  class InvoiceRenderer
    def initialize(order, display_currency:)
      @pricer = OrderPricer.new(order, display_currency: display_currency)
    end

    def lines
      @pricer.breakdown.map { |label, cents| "#{label}: #{format('%.2f', cents / 100.0)}" }
    end
  end
end
