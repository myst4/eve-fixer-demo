class ExchangeRate < ApplicationRecord
  validates :base, :quote, presence: true
end
