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
        @cash_holding = CashHolding.new(cash_holding_params)

        respond_to do |format|
          if @cash_holding.save
            format.html { redirect_to @cash_holding, notice: 'Cash holding was successfully created.' }
            format.json { render :show, status: :created, location: @cash_holding }
          else
            format.html { render :new }
            format.json { render json: @cash_holding.errors, status: :unprocessable_entity }
          end
        end
      end

      def update
        respond_to do |format|
          if @cash_holding.update(cash_holding_params)
            format.html { redirect_to @cash_holding, notice: 'Cash holding was successfully updated.' }
            format.json { render :show, status: :ok, location: @cash_holding }
          else
            format.html { render :edit }
            format.json { render json: @cash_holding.errors, status: :unprocessable_entity }
          end
        end
      end

      def destroy
        @cash_holding.destroy
        respond_to do |format|
          format.html { redirect_to cash_holdings_url, notice: 'Cash holding was successfully destroyed.' }
          format.json { head :no_content }
        end
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
