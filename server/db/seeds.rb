if Portfolio.count == 0
  ActiveRecord::Base.transaction do
    portfolio = Portfolio.create(
      name: 'demo portfolio',
      promo_portfolio: true
    )
    cash_holding = portfolio.cash_holdings.create(
      currency: CashHolding::USD
    )
    cash_holding.cash_trades.create(
      quantity: 1_000_000
    )
  end
else
  p 'database already seeded!'
end
