class MinuteBarsController < ApplicationController
  before_action :set_minute_bar, only: [:show, :update, :destroy]

  # GET /minute_bars
  # GET /minute_bars.json
  def index
    @minute_bars = MinuteBar.all
  end

  # GET /minute_bars/1
  # GET /minute_bars/1.json
  def show
  end

  # POST /minute_bars
  # POST /minute_bars.json
  def create
    @minute_bar = MinuteBar.new(minute_bar_params)

    if @minute_bar.save
      render :show, status: :created, location: @minute_bar
    else
      render json: @minute_bar.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /minute_bars/1
  # PATCH/PUT /minute_bars/1.json
  def update
    if @minute_bar.update(minute_bar_params)
      render :show, status: :ok, location: @minute_bar
    else
      render json: @minute_bar.errors, status: :unprocessable_entity
    end
  end

  # DELETE /minute_bars/1
  # DELETE /minute_bars/1.json
  def destroy
    @minute_bar.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_minute_bar
      @minute_bar = MinuteBar.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def minute_bar_params
      params.fetch(:minute_bar, {})
    end
end
