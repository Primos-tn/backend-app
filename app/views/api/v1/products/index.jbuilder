json.products @products do |id, product|
  json.id id
  json.info  product[:item]
  json.brand do
    json.name product[:brand].name
    json.id product[:brand].id
    json.followers product[:brand].followers.size
    json.cover product[:brand].cover
    json.picture product[:brand].picture
  end
  json.wishers product[:wishers] do |entry|
    unless entry.user_id.blank?
      json.name entry.username
      json.id entry.user_id
    end
  end
  if current_user and  @me_and_products[id]
    json.is_wishing true
  end
end