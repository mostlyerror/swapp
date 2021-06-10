json.extract! client, :id, :first_name, :last_name, :date_of_birth, :gender, :created_at, :updated_at
json.url client_url(client, format: :json)
