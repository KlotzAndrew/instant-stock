defmodule CheckCommandTest do
  use ExUnit.Case, async: true

  alias Commands.CheckCommand

  test "parse finds match for buy with quantity" do
    buy_command = "buy TSLA 35"
    result = CheckCommand.parse(buy_command)

    assert result
    assert result[:ticker] === "TSLA"
    assert result[:quantity] === 35
  end

  test "parse finds match for sell with default value" do
    sell_command = "sell K"
    result = CheckCommand.parse(sell_command)

    assert result
    assert result[:ticker] === "K"
    assert result[:quantity] === -1
  end

  test "parse finds negative quantity" do
    sell_command = "sell GOOG 23"
    result = CheckCommand.parse(sell_command)

    assert result
    assert result[:ticker] === "GOOG"
    assert result[:quantity] === -23
  end

  test "parse finds no match for string" do
    no_command = "not a command"
    result = CheckCommand.parse(no_command)

    refute result
  end
end
