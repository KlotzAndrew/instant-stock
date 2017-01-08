defmodule Commands.UpdateStockQuote do
  alias PhoenixApi.Repo

  alias PhoenixApi.Stock
  alias PhoenixApi.MinuteBar

  def update(quotes, repo \\ Repo) do
    update_quotes(quotes, repo)
  end

  defp update_quotes(quotes, repo) do
    Enum.each quotes, fn quote ->
      update_quote(quote, repo)
    end
  end

  defp update_quote(quote, repo) do
    stock = find_or_create_stock(quote, repo)
    create_minute_bar(stock, quote, repo)
  end

  defp create_minute_bar(stock, quote, repo) do
    repo.insert! %MinuteBar{
      stock_id:    stock.id,
      data_source: "YAHOO",
      quote_time:  Ecto.DateTime.utc,
      close:       Decimal.new(quote["LastTradePriceOnly"])
    }
  end

  defp find_or_create_stock(quote, repo) do
    stock = repo.get_by(Stock, ticker: quote["Symbol"])
    if !stock do
      stock = repo.insert! %Stock{
        ticker:         quote["Symbol"],
        stock_exchange: quote["StockExchange"],
        name:           quote["Name"],
        currency:       "USD"
      }
    end
    stock
  end
end
