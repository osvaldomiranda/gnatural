json.array!(@comments) do |comment|
  json.extract! comment, :id, :center_id, :coment
  json.url comment_url(comment, format: :json)
end
