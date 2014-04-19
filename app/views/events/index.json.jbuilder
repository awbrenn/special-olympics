json.array!(@events) do |event|
  json.extract! event, :id, :event_code, :event_name, :score_unit, :min_score, :max_score, :sort_seq
  json.url event_url(event, format: :json)
end
