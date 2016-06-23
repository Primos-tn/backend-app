json.followers @brands do |brand|
  json.name brand.name
  json.id brand.id
  json.owner brand.account.username
  json.follwers brand.followers.length
end