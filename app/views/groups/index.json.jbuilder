json.array!(@groups) do |group|
  json.extract! group, :id, :name, :created_at, :updated_at
  json.icon group.icon.as_json[:icon] if group.icon?
  json.topics group.topics, partial: 'topics/topic', as: :topic
  #json.url group_url(group, format: :json)
end
