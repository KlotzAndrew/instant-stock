# mix run priv/repo/seeds.exs

alias PhoenixApi.Repo
alias PhoenixApi.Portfolio
alias PhoenixApi.CashHolding

if Repo.aggregate(Portfolio, :count, :id) == 0 do
  portfolio = Repo.insert! %Portfolio{
    name: "Promo Portfolio"
  }
  Repo.insert! %CashHolding{
    portfolio_id: portfolio.id,
    currency: "USD"
  }
end
