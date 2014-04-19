json.array!(@groups) do |group|
  json.extract! group, :id, :group_code, :school_name, :group_leader
  json.url group_url(group, format: :json)
end
