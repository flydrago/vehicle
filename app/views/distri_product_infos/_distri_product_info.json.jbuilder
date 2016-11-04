json.extract! distri_product_info, :id, :product_name, :product_price, :created_at, :updated_at
json.url distri_product_info_url(distri_product_info, format: :json)