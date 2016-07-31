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

  validates :stock_holding_id, presence: true

  after_create_commit { TradeBroadcastJob.perform_later self }
end
