module Api
  module V1
    class StockHoldingsController < ApplicationController
      before_action :set_holding, only: [:show, :edit, :update, :destroy]

      def index
        result         = GetPortfolioStockHoldings.call portfolio_id: params[:portfolio_id]
        stock_holdings = result.stock_holdings

        render json: stock_holdings, each_serializer: StockHoldingSerializer
      end

      def show
      end

      def new
        @holding = StockHolding.new
      end

      def edit
      end

      def create
        @holding = StockHolding.new(holding_params)

        respond_to do |format|
          if @holding.save
            format.html { redirect_to @holding, notice: 'Holding was successfully created.' }
            format.json { render :show, status: :created, location: @holding }
          else
            format.html { render :new }
            format.json { render json: @holding.errors, status: :unprocessable_entity }
          end
        end
      end

      def update
        respond_to do |format|
          if @holding.update(holding_params)
            format.html { redirect_to @holding, notice: 'Holding was successfully updated.' }
            format.json { render :show, status: :ok, location: @holding }
          else
            format.html { render :edit }
            format.json { render json: @holding.errors, status: :unprocessable_entity }
          end
        end
      end

      def destroy
        @holding.destroy
        respond_to do |format|
          format.html { redirect_to holdings_url, notice: 'Holding was successfully destroyed.' }
          format.json { head :no_content }
        end
      end

      private

      def set_holding
        @holding = StockHolding.find(params[:id])
      end

      def holding_params
        params.fetch(:holding, {})
      end
    end
  end
end
