module Api
  module V1
    class PortfoliosController < ApplicationController
      before_action :set_portfolio, only: [:show, :edit, :update, :destroy]

      def promo
        result    = FindPromoPortfolio.call
        portfolio = result.portfolio

        render json: portfolio
      end

      def index
        @portfolios = Portfolio.all
      end

      def show
        @messages = Message.all
        @trades = []
        @holdings = @portfolio.holdings

        value_result = FindPortfolioValue.call portfolio: @portfolio
        @portfolio_value = value_result.value
      end

      def new
        @portfolio = Portfolio.new
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

      def set_portfolio
        @portfolio = Portfolio.includes(holdings: :trades).find(params[:id])
      end

      def portfolio_params
        params.fetch(:portfolio, {}).permit('name', 'cash')
      end
    end
  end
end
