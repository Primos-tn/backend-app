json.list @brands do |entry|
  json.name entry.name
  json.id entry.id
  json.picture entry.picture
  json.cover entry.cover
end