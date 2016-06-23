json.brands @brands do |brand|
  json.name brand.name
  json.id brand.id
  json.owner brand.account.username
  json.followers brand.followers.length
  if @followings_brands_by_brand_id[brand.id]
    json.isFollowing true
  else
    json.isFollowing false
  end
end