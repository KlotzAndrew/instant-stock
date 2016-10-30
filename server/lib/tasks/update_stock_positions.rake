namespace :fetch do
  desc 'Update quotes and update latest stock positions'
  task update_stock_positions: :environment do
    UpdateStockPosition.call
  end
end
