# Builds the human-facing invoice number printed on receipts.
class InvoiceNumber
  PREFIX = "INV"

  def initialize(order)
    @order = order
  end

  # "INV-2026-0412"
  def formatted
    [PREFIX, year, sequence].join("-")
  end

  private

  attr_reader :order

  def year
    order[:placed_at].year
  end

  def sequence
    order[:sequence].to_s.rjust(4, "0")
  end
end
