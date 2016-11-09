namespace :trade do
  desc 'Update quotes and update latest stock positions'
  task auto_trade: :environment do
    AutoTrader.new.trade
  end
end
