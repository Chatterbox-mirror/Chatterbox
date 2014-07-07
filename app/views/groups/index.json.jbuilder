json.array!(@groups) do |group|
  json.extract! group, :id, :name
  json.icon group.icon.as_json[:icon] if group.icon?
  #json.url group_url(group, format: :json)
end
