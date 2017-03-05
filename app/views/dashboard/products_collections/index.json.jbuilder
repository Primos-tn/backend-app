json.list(@collections) do |item|
  json.extract! item, :id, :name
  json.products item.products
  json.is_in
end

