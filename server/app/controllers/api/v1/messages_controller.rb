module Api
  module V1
    class MessagesController < ApplicationController
      def create
        Rails.logger.info "new message params!? #{params}"
        Message.create(
          portfolio_id: params['portfolio_id'],
          content: params['content']
        )
        render json: {}.to_json, status: 201
      end
    end
  end
end
