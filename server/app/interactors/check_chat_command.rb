class CheckChatCommand
  include Interactor

  NO_MATCH_FOUND = 'Did not detect a stock command'.freeze

  def call
    message = context[:message]

    command_message = match_command message
    ticker          = find_ticker command_message
    quantity        = find_quantity command_message

    context.quantity = quantity
    context.tickers  = [ticker]
  end

  private

  def match_command(message)
    match = check_available_commands message

    context.fail!(message: NO_MATCH_FOUND) if match.nil?
    match
  end

  def check_available_commands(message)
    /((buy|sell) [A-Z]{1,6}\s*\d*)/.match message
  end

  def find_ticker(command_message)
    command_message.string.split[1]
  end

  def find_quantity(command_message)
    quantity = command_message.string.split[2]
    return adjust_sign_input(command_message, quantity) if integer? quantity
    default_quantity(command_message)
  end

  def default_quantity(command_message)
    command = command_message.string.split[0]
    default_quantities_hash[command]
  end

  def adjust_sign_input(command_message, quantity)
    command = command_message.string.split[0]
    quantity.to_i.abs * default_quantities_hash[command]
  end

  def default_quantities_hash
    {
      buy: 1,
      sell: -1
    }.with_indifferent_access
  end

  def integer?(string)
    string =~ /\A-?\d+\z/ ? true : false
  end
end
