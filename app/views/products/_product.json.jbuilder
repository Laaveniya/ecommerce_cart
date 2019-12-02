json.extract! product, :id, :name, :brand, :rate, :created_at, :updated_at
json.url product_url(product, format: :json)
