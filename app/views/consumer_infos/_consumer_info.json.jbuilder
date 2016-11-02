json.extract! consumer_info, :id, :name, :created_at, :updated_at
json.url consumer_info_url(consumer_info, format: :json)