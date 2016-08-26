module Api
  module V1
    class PortfoliosController < ApplicationController
      before_action :set_portfolio, only: [:show, :edit, :update, :destroy]

      def promo
        result = ReturnPromoPortfolio.call

        if result.success?
          render json: {
            portfolio:      result.portfolio,
            value:          result.value,
            cash_holdings:  result.cash_holdings,
            stock_holdings: result.stock_holdings,
            portfolio_minutes: result.portfolio_minutes
          }, status:   200
        else
          render json: { error: 'something bad' }, status: 400
        end
      end

      # GET /portfolios
      # GET /portfolios.json
      def index
        @portfolios = Portfolio.all
      end

      # GET /portfolios/1
      # GET /portfolios/1.json
      def show
        @messages = Message.all
        @trades = []
        @holdings = @portfolio.holdings

        value_result = FindPortfolioValue.call portfolio: @portfolio
        @portfolio_value = value_result.value
      end

      # GET /portfolios/new
      def new
        @portfolio = Portfolio.new
      end

      # GET /portfolios/1/edit
      def edit
      end

      # POST /portfolios
      # POST /portfolios.json
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

      # PATCH/PUT /portfolios/1
      # PATCH/PUT /portfolios/1.json
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

      # DELETE /portfolios/1
      # DELETE /portfolios/1.json
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
