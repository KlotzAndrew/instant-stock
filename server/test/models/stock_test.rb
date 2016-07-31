# == Schema Information
#
# Table name: stocks
#
#  id              :uuid             not null, primary key
#  ticker          :string           not null
#  stock_exchange  :string           not null
#  name            :string
#  currency        :string           not null
#  last_quote_time :datetime
#  last_quote      :decimal(15, 2)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class StockTest < ActiveSupport::TestCase
  context '#relations' do
    should have_many :stock_holdings
    should have_many :portfolios
  end

  context '#validations' do
    should validate_presence_of :ticker
    should validate_presence_of :stock_exchange
    should validate_presence_of :currency
  end
end
