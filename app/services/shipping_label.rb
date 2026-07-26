# Builds the address block printed on a shipping label.
class ShippingLabel
  MAX_LINE = 40

  def initialize(address)
    @address = address
  end

  def lines
    [street_line, city_line].compact
  end

  private

  attr_reader :address

  def street_line
    "#{address[:street]} #{address[:number]}".upcase
  end

  def city_line
    "#{address[:city]}, #{address[:postal_code].upcase}"
  end
end
