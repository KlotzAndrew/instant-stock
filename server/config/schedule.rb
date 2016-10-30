env :PATH, ENV['PATH']
env :GEM_HOME, ENV['GEM_HOME']

set :output, { :error => 'log/cron.log', :standard => 'log/cron.log' }
set :job_template, nil

every 1.minute do
  rake 'fetch:update_stock_positions'
end
