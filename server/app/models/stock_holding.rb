# == Schema Information
#
# Table name: stock_holdings
#
#  id           :uuid             not null, primary key
#  active       :boolean          default(TRUE), not null
#  portfolio_id :uuid             not null
#  stock_id     :uuid             not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class StockHolding < ApplicationRecord
  belongs_to :portfolio
  belongs_to :stock
  has_many :stock_trades

  validates :portfolio_id, presence: true
  validates :stock_id, presence: true

  alias trades stock_trades

  def current_total
    stock_trades.to_a.sum(&:quantity)
  end

  def stock_name
    stock.name
  end

  def last_quote
    stock.last_quote
  end
end
