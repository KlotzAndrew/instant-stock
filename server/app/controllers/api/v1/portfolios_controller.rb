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
        @portfolio = Portfolio.new(portfolio_params)

        respond_to do |format|
          if @portfolio.save
            format.html { redirect_to @portfolio, notice: 'Portfolio was successfully created.' }
            format.json { render :show, status: :created, location: @portfolio }
          else
            format.html { render :new }
            format.json { render json: @portfolio.errors, status: :unprocessable_entity }
          end
        end
      end

      def update
        respond_to do |format|
          if @portfolio.update(portfolio_params)
            format.html { redirect_to @portfolio, notice: 'Portfolio was successfully updated.' }
            format.json { render :show, status: :ok, location: @portfolio }
          else
            format.html { render :edit }
            format.json { render json: @portfolio.errors, status: :unprocessable_entity }
          end
        end
      end

      def destroy
        @portfolio.destroy
        respond_to do |format|
          format.html { redirect_to portfolios_url, notice: 'Portfolio was successfully destroyed.' }
          format.json { head :no_content }
        end
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
