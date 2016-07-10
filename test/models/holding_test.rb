# == Schema Information
#
# Table name: holdings
#
#  id           :uuid             not null, primary key
#  active       :boolean          default(TRUE), not null
#  portfolio_id :uuid             not null
#  stock_id     :uuid             not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class HoldingTest < ActiveSupport::TestCase
  test '#current_total returns current stock amount' do
    holding = FactoryGirl.build :holding
    trade_1 = FactoryGirl.build :trade, holding: holding
    trade_2 = FactoryGirl.build :trade, holding: holding
    holding.trades << trade_1
    holding.trades << trade_2

    expected_total = trade_1.quantity + trade_2.quantity

    assert_equal holding.current_total, expected_total
  end
end
