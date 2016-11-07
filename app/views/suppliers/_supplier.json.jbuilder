json.extract! supplier, :id, :name, :mobile, :address, :created_at, :updated_at
json.url supplier_url(supplier, format: :json)