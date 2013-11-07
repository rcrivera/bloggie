json.array!(@tags) do |tag|
  json.extract! tag, :title, :post_id
  json.url tag_url(tag, format: :json)
end
