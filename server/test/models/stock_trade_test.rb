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

require 'test_helper'

class StockTradeTest < ActiveSupport::TestCase
  context '#relations' do
    should belong_to :stock_holding
  end

  context '#validations' do
    should validate_presence_of :stock_holding_id
  end
end
