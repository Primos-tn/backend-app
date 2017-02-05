json.reviews @reviews do |review|
  json.author review.account.username
  json.body review.body
end
json.mine @mine
