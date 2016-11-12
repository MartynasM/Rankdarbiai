json.extract! order, :id, :first_name, :last_name, :city, :adress, :email, :number, :created_at, :updated_at
json.url order_url(order, format: :json)