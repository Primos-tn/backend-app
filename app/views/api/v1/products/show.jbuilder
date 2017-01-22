json.id @product.id
json.name @product.name
json.votes_count @product.votes.size
json.pictures @product.pictures
json.brand @product.brand
json.is_voted  @is_voted
json.stores @product.stores do |store|
  json.id store.id
end