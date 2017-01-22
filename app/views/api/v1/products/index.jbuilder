json.products @products do |id, product|
  json.id id
  json.info product[:item]
  json.brand do
    json.name product[:brand].name
    json.id product[:brand].id
    json.followers product[:brand].followers.size
    json.cover product[:brand].cover
    json.picture product[:brand].picture
  end
  json.pictures product[:pictures]
  if current_user and @me_and_products[id]
    json.is_voted true
  else
    json.is_voted false
  end
end