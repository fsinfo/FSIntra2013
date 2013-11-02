json.array!(@minutes_minutes) do |minutes_minute|
  json.extract! minutes_minute, :date, :keeper_of_the_minutes_id, :chairperson_id, :released_date, :has_quorum
  json.url minutes_minute_url(minutes_minute, format: :json)
end