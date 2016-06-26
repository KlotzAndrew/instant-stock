json.array!(@cash_holdings) do |cash_holding|
  json.extract! cash_holding, :id
  json.url cash_holding_url(cash_holding, format: :json)
end
