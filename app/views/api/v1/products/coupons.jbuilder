json.result do
  json.coupons @items do |entry|
    json.value entry.value
    json.id entry.id
    json.expires entry.expires
  end
end