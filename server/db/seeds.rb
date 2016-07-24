if Portfolio.count == 0
  portfolio = Portfolio.create(
    name: 'demo portfolio',
    promo_portfolio: true
  )
  cash_holding = CashHolding.create(
    currency: CashHolding::USD,
    amount: 1_000_000
  )
  portfolio.cash_holdings << cash_holding
else
  p 'database already seeded!'
end
