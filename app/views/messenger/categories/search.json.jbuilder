json.list %w(Products Brands) do |entry|
  json.content_type 'text'
  json.title t(entry)
  json.payload 'CATEGORY_' + entry.upcase + '_SEARCH_' + @category_id.to_s
end
