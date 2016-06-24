class CheckChatCommand
  include Interactor

  NO_MATCH_FOUND = 'Did not detect a stock command'.freeze

  def call
    message = context[:message]

    command_match = match_command message
    ticker        = match_ticker command_match

    context.quantity = 1
    context.tickers   = [ticker]
  end

  private

  def match_command(message)
    match = check_available_commands message

    context.fail!(message: NO_MATCH_FOUND) if match.nil?
    match
  end

  def check_available_commands(message)
    /(buy [A-Z]{1,6})/.match(message)
  end

  def match_ticker(command)
    command.string[4..command.string.length-1]
  end
end

