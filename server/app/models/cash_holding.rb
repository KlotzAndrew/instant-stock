# == Schema Information
#
# Table name: cash_holdings
#
#  id           :uuid             not null, primary key
#  currency     :string           not null
#  portfolio_id :uuid             not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class CashHolding < ApplicationRecord
  belongs_to :portfolio
  has_many :cash_trades

  validates :portfolio_id, presence: true
  validates :currency, presence: true

  USD = 'USD'.freeze

  def current_total
    cash_trades.to_a.sum(&:quantity)
  end

  def change_cash(amount_change)
    new_amount = amount + amount_change
    update amount: new_amount
  end
end
