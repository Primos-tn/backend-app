# json.products @products do |id, product|
#   json.id id
#   json.info product[:item]
#   json.brand do
#     json.name product[:brand].name
#     json.id product[:brand].id
#     json.followers product[:brand].followers.size
#     json.cover product[:brand].cover
#     json.picture product[:brand].picture
#   end
#   json.pictures product[:pictures]
#   if current_user and @me_and_products[id]
#     json.is_voted true
#   else
#     json.is_voted false
#   end
# end
json.products @products do |product_launch|
  json.id product_launch.product_id
  json.info product_launch.product
  json.brand do
    json.name product_launch.product.brand.name
    json.id product_launch.product.brand.id
    json.cover product_launch.product.brand.cover
    json.picture product_launch.product.brand.picture
    json.followers_count product_launch.product.brand.followers.size
  end
  json.pictures product_launch.product.pictures
  json.stores product_launch.product.stores

  if @collections.has_key?(product_launch.products_collection_id)
    json.collection @collections[product_launch.products_collection_id] do |entry|
      json.id entry.product.id
      json.pictures entry.product.pictures
    end
  else
    if current_user and @me_and_products[product_launch.product_id]
      json.is_voted true
    else
      json.is_voted false
    end
  end
end