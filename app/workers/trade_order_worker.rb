class TradeOrderWorker
  include Sidekiq::Worker

  def perform(some_string)
    new_message = Message.create(content: Message.count)
    ActionCable.server.broadcast 'room_channel', message: render_message(new_message)
  end

  private

  def render_message(message)
    Rails.logger.info "this message is => #{message}"
    ApplicationController.renderer.render(
      partial: 'messages/message', locals: { message: message }
    )
  end
end