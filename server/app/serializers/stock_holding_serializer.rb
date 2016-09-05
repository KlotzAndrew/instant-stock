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

class StockHoldingSerializer < ActiveModel::Serializer
  attributes :id, :portfolio_id, :stock_id, :current_total

  belongs_to :portfolio
  belongs_to :stock
  has_many :stock_trades

  def current_total
    object.current_total
  end
end
