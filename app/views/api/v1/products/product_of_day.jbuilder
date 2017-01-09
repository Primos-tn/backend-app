json.result @products do |product|
  json.name product.name
  json.id product.id
  json.wishers product.wishers.size
  json.pictures product.pictures.all
end