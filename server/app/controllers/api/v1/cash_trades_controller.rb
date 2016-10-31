class CashTradesController < ApplicationController
  before_action :set_cash_trade, only: [:show, :update, :destroy]

  # GET /cash_trades
  # GET /cash_trades.json
  def index
    @cash_trades = CashTrade.all
  end

  # GET /cash_trades/1
  # GET /cash_trades/1.json
  def show
  end

  # POST /cash_trades
  # POST /cash_trades.json
  def create
    @cash_trade = CashTrade.new(cash_trade_params)

    if @cash_trade.save
      render :show, status: :created, location: @cash_trade
    else
      render json: @cash_trade.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cash_trades/1
  # PATCH/PUT /cash_trades/1.json
  def update
    if @cash_trade.update(cash_trade_params)
      render :show, status: :ok, location: @cash_trade
    else
      render json: @cash_trade.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cash_trades/1
  # DELETE /cash_trades/1.json
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
