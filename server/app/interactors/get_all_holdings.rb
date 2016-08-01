class GetAllHoldings
  include Interactor

  def call
    portfolio      = context.portfolio
    cash_holdings  = get_cash_holdings portfolio
    stock_holdings = get_stock_holdings portfolio

    context.cash_holdings  = cash_holdings
    context.stock_holdings = stock_holdings
  end

  private

  def get_cash_holdings(portfolio)
    cash_holdings = portfolio.cash_holdings
    cash_holdings.each_with_object([]) do |h, arr|
      arr << build_cash_holding_hash(h)
    end
  end

  def build_cash_holding_hash(holding)
    hash                  = holding.attributes
    hash['current_total'] = holding.current_total
    hash
  end

  def get_stock_holdings(portfolio)
    stock_holdings = portfolio.stock_holdings
    stock_holdings.each_with_object([]) do |h, arr|
      arr << build_stock_holding_hash(h)
    end
  end

  def build_stock_holding_hash(holding)
    hash                  = holding.attributes
    hash['current_total'] = holding.current_total
    hash['name']          = holding.stock.name
    hash
  end
end
