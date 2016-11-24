json.array!(@category_products) do |category_product|
  json.extract! category_product, :id, :category_id, :product_id
  json.url category_product_url(category_product, format: :json)
end
