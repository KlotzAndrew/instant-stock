module TradingStrategies
  class RandomTrades
    def initialize(stock_holdings, cash_holdings)
      @stock_holdings = stock_holdings
      @cash_holdings = cash_holdings
    end

    def calculate
      @stock_holdings.map do |holding|
        {
          stock: holding.stock,
          quantity: rand(-5..5)
        }
      end
    end
  end
end
