# == Schema Information
#
# Table name: cash_trades
#
#  id              :uuid             not null, primary key
#  cash_holding_id :uuid             not null
#  quantity        :decimal(15, 2)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class CashTradeTest < ActiveSupport::TestCase
  context '#relations' do
    should belong_to :cash_holding
  end

  context '#validations' do
    should validate_presence_of :cash_holding_id
  end

  test '#holding equals cash_holding' do
    CashTrade.new.holding == CashTrade.new.cash_holding
  end
end
