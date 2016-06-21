class Portfolio < ApplicationRecord
  has_many :holdings
  has_many :stocks, through: :holdings
end
