# portfolio of assets
class PortfolioController < ApplicationController
  def show
    @messages = Message.all
  end
end
