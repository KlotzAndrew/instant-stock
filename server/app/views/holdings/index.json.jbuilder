json.array!(@holdings) do |holding|
  json.extract! holding, :id
  json.url holding_url(holding, format: :json)
end
