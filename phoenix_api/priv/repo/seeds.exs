# mix run priv/repo/seeds.exs

alias PhoenixApi.Repo
alias PhoenixApi.Portfolio

if Repo.aggregate(Portfolio, :count, :id) == 0
  Repo.insert! %Portfolio{
    name: "Promo Portfolio"
  }
end
