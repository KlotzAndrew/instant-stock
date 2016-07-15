# == Schema Information
#
# Table name: portfolios
#
#  id         :uuid             not null, primary key
#  name       :string
#  cash       :decimal(15, 2)   default(0.0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Portfolio < ApplicationRecord
  has_many :holdings
  has_many :cash_holdings
  has_many :stocks, through: :holdings

  validates :name, presence: true
  validates :cash, presence: true

  def change_cash(amount, currency)
    holding = cash_holdings.find_by currency: currency
    holding.change_cash amount
  end
end
