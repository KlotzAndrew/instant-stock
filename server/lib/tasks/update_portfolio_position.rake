namespace :fetch do
  desc 'Update quotes and update latest stock positions'
  task update_portfolio_position: :environment do
    PortfolioPositionUpdater.new.update
  end
end
