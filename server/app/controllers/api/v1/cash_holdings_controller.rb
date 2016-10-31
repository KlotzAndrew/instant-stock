module Api
  module V1
    class CashHoldingsController < ApplicationController
      before_action :set_cash_holding, only: [:show, :edit, :update, :destroy]

      def index
        call_params   = { portfolio_id: params[:portfolio_id] }
        result        = GetPortfolioCashHoldings.call call_params
        cash_holdings = result.cash_holdings

        render json: cash_holdings, each_serializer: CashHoldingSerializer
      end

      def show
      end

      def new
        @cash_holding = CashHolding.new
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

      def set_cash_holding
        @cash_holding = CashHolding.find(params[:id])
      end

      def cash_holding_params
        params.fetch(:cash_holding, {})
      end
    end
  end
end
