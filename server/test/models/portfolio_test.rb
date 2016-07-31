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

  test 'requires name' do
    @portfolio.name = nil
    refute @portfolio.valid?
  end

  test '#change_cash calls cash holding' do
    mock_amount   = 100
    mock_currency = CashHolding::USD

    @portfolio.cash_holdings
              .expects(:find_by)
              .with(currency: mock_currency)
              .returns(@cash_holding)

    @cash_holding.expects(:change_cash).with(mock_amount)

    @portfolio.change_cash(mock_amount, mock_currency)
  end
end
