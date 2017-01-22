json.name @brand.name
json.id @brand.id
json.cover @brand.cover
json.followers_count @brand.followers.size
json.stores_count @brand.stores.size
json.products_count @brand.products.size
json.is_following false
if current_user and @me_and_brands[@brand.id]
  json.is_following true
end