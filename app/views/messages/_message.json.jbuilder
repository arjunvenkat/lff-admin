json.extract! message, :id, :first_name, :last_name, :org_name, :email, :phone, :message, :created_at, :updated_at
json.url message_url(message, format: :json)
