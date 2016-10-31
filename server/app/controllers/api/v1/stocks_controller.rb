class StocksController < ApplicationController
  before_action :set_stock, only: [:show, :edit, :update, :destroy]

  def index
    @stocks = Stock.all
  end

  def show
  end

  def new
    @stock = Stock.new
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

  def set_stock
    @stock = Stock.find(params[:id])
  end

  def stock_params
    params.fetch(:stock, {})
  end
end
