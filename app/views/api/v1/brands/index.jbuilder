json.brands @brands do |brand|
  json.name brand.name
  json.id brand.id
  json.owner brand.account.username
  json.cover brand.cover
  json.followers_count brand.followers.size
  json.is_following = false
  json.stores brand.stores do |store|
    unless @exclude_stores_ids.include?(store.id)
      json.name store.name
      json.lat store.latitude
      json.lng store.longitude
    end
  end

  json.category brand.category
  if current_user and @me_and_brands[brand.id]
    json.is_following true
  end
  if @followers_by_brands_id.has_key?(brand.id)
    json.followers @followers_by_brands_id[brand.id].each do |follower|
      json.username follower.username
      json.id follower.user_id
    end
  end
end
