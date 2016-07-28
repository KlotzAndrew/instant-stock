module Api
  module V1
    class MessagesController < ApplicationController
      def create
        Message.create(
          portfolio_id: params['portfolio_id'],
          content: params['content']
        )
        trade_params = {
          portfolio_id: params[:portfolio_id],
          message: params[:content]
        }
        ExecutePortfolioTrade.call trade_params
        render json: {}.to_json, status: 201
      end
    end
  end
end
