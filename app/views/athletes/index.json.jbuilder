json.array!(@athletes) do |athlete|
  json.extract! athlete, :id, :group_id, :first_name, :last_name, :age, :gender, :score
  json.url athlete_url(athlete, format: :json)
end
