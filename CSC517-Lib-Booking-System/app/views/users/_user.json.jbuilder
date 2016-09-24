json.extract! user, :id, :email, :password, :name, :authority, :created_at, :updated_at
json.url user_url(user, format: :json)