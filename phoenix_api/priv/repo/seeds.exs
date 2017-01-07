# mix run priv/repo/seeds.exs

alias PhoenixApi.Repo
alias PhoenixApi.Portfolio
alias PhoenixApi.CashHolding
alias PhoenixApi.CashTrade

if Repo.aggregate(Portfolio, :count, :id) == 0 do
  portfolio = Repo.insert! %Portfolio{
    name: "Promo Portfolio"
  }
  cash_holding = Repo.insert! %CashHolding{
    portfolio_id: portfolio.id,
    currency: "USD"
  }
  Repo.insert! %CashTrade{
    cash_holding_id: cash_holding.id,
    quantity: 1_000_000
  }
end
