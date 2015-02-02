json.array!(@user_credits) do |user_credit|
  json.extract! user_credit, :id, :user_id, :item_id, :credit
  json.url user_credit_url(user_credit, format: :json)
end
