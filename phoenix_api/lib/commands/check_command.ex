defmodule Commands.CheckCommand do
  @default_quantity "1"

  def parse(string) do
    command_msg = Regex.run(buy_sell_regex, string, capture: :first)

    if command_msg do
      %{
        tickers: [stock_ticker(command_msg)],
        quantity: stock_quantity(command_msg)
      }
    end
  end

  defp buy_sell_regex do
    ~r/((buy|sell) [A-Z]{1,6}\s*\d*)/
  end

  defp stock_ticker(command_msg) do
    command_at_position(command_msg, 1)
  end

  defp stock_quantity(command_msg) do
    quantity = command_at_position(command_msg, 2) || @default_quantity
    adjust_quantity_sign(quantity, command_at_position(command_msg, 0))
  end

  defp adjust_quantity_sign(quantity, buy_sell) do
    {integer, _} = Integer.parse(quantity)
    integer * buy_sell_signs[buy_sell]
  end

  defp buy_sell_signs do
    %{
      "buy" => 1,
      "sell" => -1
    }
  end

  defp command_at_position(command_msg, position) do
    message = hd(command_msg)
    commands = String.split(message, " ")
    Enum.at(commands, position)
  end
end
