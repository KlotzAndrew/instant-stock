json.array!(@day_bars) do |day_bar|
  json.extract! day_bar, :id
  json.url day_bar_url(day_bar, format: :json)
end
