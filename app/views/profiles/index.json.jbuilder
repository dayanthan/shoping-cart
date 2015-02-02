json.array!(@profiles) do |profile|
  json.extract! profile, :id, :address, :city, :state, :country, :mobile, :avatar, :date_of_birth, :user_id
  json.url profile_url(profile, format: :json)
end
