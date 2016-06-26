# == Schema Information
#
# Table name: trades
#
#  id          :uuid             not null, primary key
#  holding_id  :uuid             not null
#  quantity    :integer          not null
#  enter_price :decimal(15, 2)
#  exit_price  :decimal(15, 2)
#  ex          :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class TradeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
