json.array!(@comments) do |comment|
  json.extract! comment, :id, :topic_id, :content, :created_at
  json.user do
    json.name comment.user.name
    json.id comment.user_id
  end
  # json.url comment_url(comment, format: :json)
end
