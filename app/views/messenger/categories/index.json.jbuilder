json.list @items do |entry|
  json.content_type 'text'
  json.title humanize_category_name(entry)
  json.payload MessengerConstants::CATEGORY_SELECT_PREFIX.to_s + entry.id.to_s
end
