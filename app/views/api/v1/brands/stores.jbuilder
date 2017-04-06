json.stores @items do |entry|
  json.name entry.name
  json.id entry.id
  json.lat entry.latitude
  json.lng entry.longitude
  json.products entry.products.count
  json.picture entry.brand.picture
end