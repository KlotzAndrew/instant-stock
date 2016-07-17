# portfolio of assets
class PortfolioController < ApplicationController
  def show
    @messages = Message.all
  end

  def message
    value = params["value"]
    TradeOrderWorker.perform_in(10.seconds, "#{value}")
    redirect_to portfolio_show_path
  end
end
