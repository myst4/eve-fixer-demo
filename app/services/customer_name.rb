# Formats a customer's display name for the UI.
class CustomerName
  def initialize(customer)
    @customer = customer
  end

  # "Ada Lovelace", or just "Ada" when there is no last name.
  def full
    "#{first_name} #{last_name}".strip
  end

  # "A. Lovelace" — used in the compact order list.
  def short
    "#{first_name[0]}. #{last_name}"
  end

  private

  attr_reader :customer

  def first_name
    customer[:first_name]
  end

  def last_name
    customer[:last_name].to_s.strip
  end
end
