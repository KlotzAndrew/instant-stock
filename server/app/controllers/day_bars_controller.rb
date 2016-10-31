class DayBarsController < ApplicationController
  before_action :set_day_bar, only: [:show, :update, :destroy]

  def index
    @day_bars = DayBar.all
  end

  def show
  end

  def create
    @day_bar = DayBar.new(day_bar_params)

    if @day_bar.save
      render :show, status: :created, location: @day_bar
    else
      render json: @day_bar.errors, status: :unprocessable_entity
    end
  end

  def update
    if @day_bar.update(day_bar_params)
      render :show, status: :ok, location: @day_bar
    else
      render json: @day_bar.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @day_bar.destroy
  end

  private

  def set_day_bar
    @day_bar = DayBar.find(params[:id])
  end

  def day_bar_params
    params.fetch(:day_bar, {})
  end
end
