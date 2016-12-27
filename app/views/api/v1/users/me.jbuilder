json.result do
  json.last_name @profile.last_name
  json.first_name @profile.first_name
  json.brands current_user.favorite_brands
end
