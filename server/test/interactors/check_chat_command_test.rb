require 'test_helper'

class CheckChatCommandTest < ActiveSupport::TestCase
  test '#call with buy returns ticker and default quantity' do
    mock_quantity = '1'
    mock_tickers  = ['TICKER']
    mock_message  = "buy #{mock_tickers[0]}"

    result = CheckChatCommand.call(message: mock_message)

    assert result.success?
    assert_equal mock_tickers, result.tickers
    assert_equal mock_quantity.to_i, result.quantity
  end

  test '#call with sell returns ticker and default quantity' do
    mock_quantity = '-1'
    mock_ticker = ['TICKER']
    mock_message = "sell #{mock_ticker[0]}"

    result = CheckChatCommand.call(message: mock_message)

    assert result.success?
    assert_equal mock_ticker, result.tickers
    assert_equal mock_quantity.to_i, result.quantity
  end

  test '#call fails when no command match' do
    mock_message = 'nada'

    result = CheckChatCommand.call(message: mock_message)

    refute result.success?
    assert_equal CheckChatCommand::NO_MATCH_FOUND, result.message
  end

  test '#call with buy returns ticker and any quantity' do
    mock_quantity = '120'
    mock_tickers  = ['TICKER']
    mock_message  = "buy #{mock_tickers[0]} #{mock_quantity}"

    result = CheckChatCommand.call(message: mock_message)

    assert result.success?
    assert_equal mock_tickers, result.tickers
    assert_equal mock_quantity.to_i, result.quantity
  end

  test '#call with sell returns ticker and any quantity' do
    mock_quantity = '120'
    mock_tickers  = ['TICKER']
    mock_message  = "sell #{mock_tickers[0]} #{mock_quantity}"

    result = CheckChatCommand.call(message: mock_message)

    assert result.success?
    assert_equal mock_tickers, result.tickers
    assert_equal mock_quantity.to_i * -1, result.quantity
  end

  test '#call with string after ticker returns ticker/quantity' do
    mock_quantity = '1'
    mock_tickers  = ['TICKER']
    mock_message  = "buy #{mock_tickers[0]} zomg"

    result = CheckChatCommand.call(message: mock_message)

    assert result.success?
    assert_equal mock_tickers, result.tickers
    assert_equal mock_quantity.to_i, result.quantity
  end
end
