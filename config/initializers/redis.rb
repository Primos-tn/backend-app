
$redis = Redis::Namespace.new(Rails.env + "primos", :redis => Redis.new)