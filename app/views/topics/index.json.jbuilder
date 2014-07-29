json.array!(@topics) do |topic|
  json.extract! topic, :id, :title, :description, :group_id, :owner_id, :status
  #json.url topic_url(topic, format: :json)
end
