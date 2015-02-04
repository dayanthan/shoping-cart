json.array!(@items) do |item|
  json.extract! item, :id, :name, :discription, :price, :discount, :category_id, :user_id, :available
  json.url item_url(item, format: :json)
end
