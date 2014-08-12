json.extract! comment, :id, :type, :topic_id, :content, :created_at
json.user do
  json.name comment.user.name
  json.id comment.user_id
end
if comment.is_a?(Picture)
  json.picture comment.picture
end
