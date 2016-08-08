# == Schema Information
#
# Table name: portfolios
#
#  id              :uuid             not null, primary key
#  name            :string
#  promo_portfolio :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class PortfolioTest < ActiveSupport::TestCase
  def setup
    @portfolio    = FactoryGirl.build :portfolio
    @cash_holding = FactoryGirl.build :cash_holding, portfolio: @portfolio
    @portfolio.cash_holdings << @cash_holding
  end

  context '#relations' do
    should have_many :stock_holdings
    should have_many :cash_holdings
    should have_many :stocks
    should have_many :messages
  end

  context '#validations' do
    should validate_presence_of :name
  end
end
