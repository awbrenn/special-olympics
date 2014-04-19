json.array!(@heats) do |heat|
  json.extract! heat, :id, :event_id, :gender, :min_age, :max_age, :time, :num_heats
  json.url heat_url(heat, format: :json)
end
