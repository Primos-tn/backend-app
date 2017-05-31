json.reviews @reviews do |review|
  json.author review.account.username
  json.body review.body
  json.eval review.eval
  json.author_id review.account.id
  json.created_at review.created_at
end
json.mine @mine
