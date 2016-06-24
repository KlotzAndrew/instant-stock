require 'test_helper'

class CheckChatCommandTest < ActiveSupport::TestCase
  test 'returns ticker for buy command' do
    mock_quantity = 1
    mock_tickers   = ['TICKER']
    mock_message  = "buy #{mock_tickers[0]}"

    result = CheckChatCommand.call({message: mock_message})

    assert result.success?
    assert_equal mock_tickers, result.tickers
    assert_equal mock_quantity, result.quantity
  end

  test 'returns ticker for sell command' do
    skip 'need to impliment multiple commands'
    mock_quantity = -1
    mock_ticker = 'TICKER'
    mock_message = "sell #{mock_ticker}"

    result = CheckChatCommand.call({message: mock_message})

    assert result.success?
    assert_equal mock_ticker, result.ticker
    assert_equal mock_quantity, result.quantity
  end

  test 'fails when no command match' do
    mock_message = 'nada'

    result = CheckChatCommand.call({message: mock_message})

    refute result.success?
    assert_equal CheckChatCommand::NO_MATCH_FOUND, result.message
  end
end
