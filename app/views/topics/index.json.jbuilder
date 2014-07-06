json.array!(@topics) do |topic|
  json.extract! topic, :id, :name, :description, :group_id
  #json.url topic_url(topic, format: :json)
end
