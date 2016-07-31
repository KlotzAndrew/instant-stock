json.array!(@cash_trades) do |cash_trade|
  json.extract! cash_trade, :id
  json.url cash_trade_url(cash_trade, format: :json)
end
