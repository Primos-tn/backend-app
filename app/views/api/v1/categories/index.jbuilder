json.categories @categories do |item|
  json.name locale.equal?(:ar) ? item.name_ar : (locale.equal?(:fr) ? item.name_fr : item.name).upcase
end