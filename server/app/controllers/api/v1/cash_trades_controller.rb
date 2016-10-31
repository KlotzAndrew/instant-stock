class CashTradesController < ApplicationController
  before_action :set_cash_trade, only: [:show, :update, :destroy]

  def index
    @cash_trades = CashTrade.all
  end

  def show
  end

  def create
  end

  def update
  end

  def destroy
    @cash_trade.destroy
  end

  private

  def set_cash_trade
    @cash_trade = CashTrade.find(params[:id])
  end

  def cash_trade_params
    params.fetch(:cash_trade, {})
  end
end
