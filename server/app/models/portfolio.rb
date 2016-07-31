# == Schema Information
#
# Table name: portfolios
#
#  id              :uuid             not null, primary key
#  name            :string
#  promo_portfolio :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Portfolio < ApplicationRecord
  has_many :stock_holdings
  has_many :cash_holdings
  has_many :stocks, through: :stock_holdings

  validates :name, presence: true

  def change_cash(amount, currency)
    holding = cash_holdings.find_by currency: currency
    holding.change_cash amount
  end
end
