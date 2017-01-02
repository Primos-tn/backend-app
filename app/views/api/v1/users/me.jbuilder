json.result do
  json.username @user.username
  json.id @user.id
  json.last_name @profile.last_name
  json.first_name @profile.first_name
  json.brands current_user.favorite_brands.count
end
