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

class StockTrade < ApplicationRecord
  belongs_to :stock_holding
  has_one :stock, through: :stock_holding

  validates :stock_holding_id, presence: true

  alias holding stock_holding

  after_create_commit { StockTradeBroadcastJob.perform_later self }

  def stock_name
    stock.name
  end
end
