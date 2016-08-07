class DayBarsController < ApplicationController
  before_action :set_day_bar, only: [:show, :update, :destroy]

  # GET /day_bars
  # GET /day_bars.json
  def index
    @day_bars = DayBar.all
  end

  # GET /day_bars/1
  # GET /day_bars/1.json
  def show
  end

  # POST /day_bars
  # POST /day_bars.json
  def create
    @day_bar = DayBar.new(day_bar_params)

    if @day_bar.save
      render :show, status: :created, location: @day_bar
    else
      render json: @day_bar.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /day_bars/1
  # PATCH/PUT /day_bars/1.json
  def update
    if @day_bar.update(day_bar_params)
      render :show, status: :ok, location: @day_bar
    else
      render json: @day_bar.errors, status: :unprocessable_entity
    end
  end

  # DELETE /day_bars/1
  # DELETE /day_bars/1.json
  def destroy
    @day_bar.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_day_bar
      @day_bar = DayBar.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def day_bar_params
      params.fetch(:day_bar, {})
    end
end
