json.result do
  json.reviews @items do |entry|
    json.username entry.account.username
    json.id entry.account.id
  end
end