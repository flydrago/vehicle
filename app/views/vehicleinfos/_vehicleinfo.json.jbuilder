json.extract! vehicleinfo, :id, :vehicle_name, :vehicle_model, :created_at, :updated_at
json.url vehicleinfo_url(vehicleinfo, format: :json)