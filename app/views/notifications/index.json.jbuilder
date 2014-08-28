json.array!(@notifications) do |notification|
  json.extract! notification, :id
end
