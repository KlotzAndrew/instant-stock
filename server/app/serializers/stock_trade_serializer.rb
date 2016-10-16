# == Schema Information
#
# Table name: stock_trades
#
#  id               :uuid             not null, primary key
#  stock_holding_id :uuid             not null
#  quantity         :integer          not null
#  enter_price      :decimal(15, 2)
#  exit_price       :decimal(15, 2)
#  exit_time        :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class StockTradeSerializer < ActiveModel::Serializer
  attributes :id, :stock_holding_id, :quantity, :enter_price, :created_at, :stock_name

  belongs_to :stock_holding

  def stock_name
    object.stock_name
  end
end
