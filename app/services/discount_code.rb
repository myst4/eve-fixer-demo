# Normalises a promo code typed by a customer.
class DiscountCode
  def initialize(raw)
    @raw = raw
  end

  # Codes are stored upper case with no surrounding whitespace.
  def normalized
    raw.strip.upcase
  end

  def valid?
    normalized.length.between?(4, 12)
  end

  private

  attr_reader :raw
end
