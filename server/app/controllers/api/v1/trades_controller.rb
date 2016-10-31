class TradesController < ApplicationController
  before_action :set_trade, only: [:show, :edit, :update, :destroy]

  def index
    @trades = StockTrade.all
  end

  def show
  end

  def new
    @trade = StockTrade.new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

  private

  def set_trade
    @trade = StockTrade.find(params[:id])
  end

  def trade_params
    params.fetch(:trade, {})
  end
end
