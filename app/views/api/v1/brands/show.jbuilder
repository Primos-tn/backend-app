json.name @brand.name
json.id @brand.id
json.cover @brand.cover
json.followers_count @brand.followers.size
json.stores_count @brand.stores.size
json.products_count @brand.products.size
json.reviews_count @brand.reviews.size
json.is_following false
json.ln_link @brand.ln_link
json.fb_link @brand.fb_link
json.tw_link @brand.tw_link
json.address @brand.address

if @brand.category
  if locale.equal?(:ar)
    json.category @brand.category.name_ar
  elsif locale.equal?(:fr)
    json.category @brand.category.name_fr
  else
    json.category @brand.category.name
  end
end

if current_user and @me_and_brands[@brand.id]
  json.is_following true
end