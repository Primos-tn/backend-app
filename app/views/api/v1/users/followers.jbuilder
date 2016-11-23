json.followers @followers do |entry|
  json.name entry.account.username
  json.id entry.account.id
end