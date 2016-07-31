# == Schema Information
#
# Table name: cash_holdings
#
#  id           :uuid             not null, primary key
#  amount       :decimal(15, 2)
#  currency     :string           not null
#  portfolio_id :uuid             not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class CashHolding < ApplicationRecord
  belongs_to :portfolio

  validates :portfolio_id, presence: true
  validates :currency, presence: true

  USD = 'USD'.freeze

  def change_cash(amount_change)
    new_amount = amount + amount_change
    update amount: new_amount
  end
end
