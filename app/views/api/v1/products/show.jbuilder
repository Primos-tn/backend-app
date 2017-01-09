json.id @product.id
json.name @product.name
json.wishers @product.wishers.size
json.pictures @product.pictures
json.brand @product.brand
json.stores @product.stores do |store|
  json.id store.id
end