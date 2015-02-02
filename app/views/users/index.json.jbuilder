json.array!(@users) do |user|
  json.extract! user, :id, :user_id, :user_name, :user_email, :password, :user_type
  json.url user_url(user, format: :json)
end
