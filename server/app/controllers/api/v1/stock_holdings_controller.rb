module Api
  module V1
    class StockHoldingsController < ApplicationController
      before_action :set_holding, only: [:show, :edit, :update, :destroy]

      def index
        call_params = { portfolio_id: params[:portfolio_id] }
        result         = GetPortfolioStockHoldings.call call_params
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
      end

      def update
      end

      def destroy
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
