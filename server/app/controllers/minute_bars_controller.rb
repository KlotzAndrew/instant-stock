class MinuteBarsController < ApplicationController
  before_action :set_minute_bar, only: [:show, :update, :destroy]

  def index
    @minute_bars = MinuteBar.all
  end

  def show
  end

  def create
    @minute_bar = MinuteBar.new(minute_bar_params)

    if @minute_bar.save
      render :show, status: :created, location: @minute_bar
    else
      render json: @minute_bar.errors, status: :unprocessable_entity
    end
  end

  def update
    if @minute_bar.update(minute_bar_params)
      render :show, status: :ok, location: @minute_bar
    else
      render json: @minute_bar.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @minute_bar.destroy
  end

  private

  def set_minute_bar
    @minute_bar = MinuteBar.find(params[:id])
  end

  def minute_bar_params
    params.fetch(:minute_bar, {})
  end
end
