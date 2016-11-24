json.array!(@dashboard_brands_stores) do |dashboard_brands_store|
  json.extract! dashboard_brands_store, :id
  json.url dashboard_brands_store_url(dashboard_brands_store, format: :json)
end
