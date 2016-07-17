class CashHoldingsController < ApplicationController
  before_action :set_cash_holding, only: [:show, :edit, :update, :destroy]

  # GET /cash_holdings
  # GET /cash_holdings.json
  def index
    @cash_holdings = CashHolding.all
  end

  # GET /cash_holdings/1
  # GET /cash_holdings/1.json
  def show
  end

  # GET /cash_holdings/new
  def new
    @cash_holding = CashHolding.new
  end

  # GET /cash_holdings/1/edit
  def edit
  end

  # POST /cash_holdings
  # POST /cash_holdings.json
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

  # PATCH/PUT /cash_holdings/1
  # PATCH/PUT /cash_holdings/1.json
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

  # DELETE /cash_holdings/1
  # DELETE /cash_holdings/1.json
  def destroy
    @cash_holding.destroy
    respond_to do |format|
      format.html { redirect_to cash_holdings_url, notice: 'Cash holding was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cash_holding
      @cash_holding = CashHolding.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cash_holding_params
      params.fetch(:cash_holding, {})
    end
end
