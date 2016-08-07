json.array!(@minute_bars) do |minute_bar|
  json.extract! minute_bar, :id
  json.url minute_bar_url(minute_bar, format: :json)
end
