defmodule Commands.TradeStock do
  import Ecto.Query, only: [from: 2]
  alias PhoenixApi.Repo

  alias PhoenixApi.Stock
  alias PhoenixApi.MinuteBar
  alias PhoenixApi.Portfolio
  alias PhoenixApi.StockHolding
  alias PhoenixApi.StockTrade
  alias PhoenixApi.CashHolding
  alias PhoenixApi.CashTrade

  def trade(portfolio_id, command, repo \\ Repo) do
    portfolio = repo.get(Portfolio, portfolio_id)
    complete_trades(portfolio, command, repo)
  end

  defp complete_trades(portfolio, command, repo) do
    stock         = find_stock(command.tickers, repo)
    last_quote    = find_last_stock_quote(stock, repo)
    stock_holding = find_or_create_stock_holding(portfolio, stock, repo)
    cash_holding  = find_or_create_cash_holding(portfolio, stock, repo)

    perform_trade(stock_holding, cash_holding, last_quote, stock, command.quantity, repo)
  end

  defp perform_trade(stock_holding, cash_holding, last_quote, stock, quantity, repo) do
    result = repo.transaction fn ->
      create_cash_trade(cash_holding, last_quote, quantity, repo)
      create_stock_trade(stock_holding, last_quote, quantity, repo)
    end

    result
  end

  defp create_cash_trade(cash_holding, last_quote, quantity, repo) do
    amount = Decimal.mult(last_quote.close, Decimal.new(quantity))
    amount = Decimal.mult(amount, Decimal.new(-1))
    repo.insert! %CashTrade{
      cash_holding_id: cash_holding.id,
      quantity:        amount
    }
  end

  defp create_stock_trade(stock_holding, last_quote, quantity, repo) do
    repo.insert! %StockTrade{
      stock_holding_id: stock_holding.id,
      enter_price:      last_quote.close,
      quantity:         quantity
    }
  end

  defp find_stock(tickers, repo) do
    repo.get_by(Stock, ticker: Enum.at(tickers, 0))
  end

  defp find_or_create_stock_holding(portfolio, stock, repo) do
    holding = repo.get_by(StockHolding, stock_id: stock.id, portfolio_id: portfolio.id)
    if !holding do
      holding = repo.insert! %StockHolding{stock_id: stock.id, portfolio_id: portfolio.id}
    end
    holding
  end

  defp find_or_create_cash_holding(portfolio, stock, repo) do
    holding = repo.get_by(CashHolding, portfolio_id: portfolio.id, currency: stock.currency)
    if !holding do
      holding = repo.insert! %CashHolding{portfolio_id: portfolio.id, currency: stock.currency}
    end
    holding
  end

  defp find_last_stock_quote(stock, repo) do
    query = from(m in MinuteBar, order_by: m.inserted_at, where: m.stock_id == ^stock.id)
    minute_bars = repo.all(query)
    Enum.at(minute_bars, 0)
  end
end
