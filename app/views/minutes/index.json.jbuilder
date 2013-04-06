json.array!(@minutes) do |minute|
  json.extract! minute, :date, :status
  json.url minute_url(minute, format: :json)
end