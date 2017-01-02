json.result do
  json.username @user.username
  json.brands @user.favorite_brands.count
end
