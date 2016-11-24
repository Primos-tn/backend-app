json.result do
  json.wishers @items do |entry|
    json.username entry.account.username
    json.id entry.account.id
    json.products_count entry.account.favorite_products.size
    json.brands_count entry.account.favorite_brands.size
  end
end