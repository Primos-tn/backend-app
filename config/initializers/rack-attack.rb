# Throttle requests to 5 requests per second per ip
# # FIXME check  ban2ail
# Rack::Attack.throttle('req/ip', :limit => 20, :period => 1.second) do |req|
#   # If the return value is truthy, the cache key for the return value
#   # is incremented and compared with the limit. In this case:
#   #   "rack::attack:#{Time.now.to_i/1.second}:req/ip:#{req.ip}"
#   #
#   # If falsy, the cache key is neither incremented nor checked.
#   req.ip
# end
# Throttle login attempts for a given email parameter to 6 reqs/minute
# Return the email as a discriminator on POST /login requests
Rack::Attack.throttle('accounts/*', :limit => 6, :period => 60.seconds) do |req|
  req.params['email'] if req.path == '/login' && req.post?
end

# prevent
Rack::Attack.throttle('api/accounts/ip', :limit => 5, :period => 20.seconds) do |req|
  if req.path == 'accounts/sign_in' && req.post?
    req.ip
  end
end

# throttle on create
Rack::Attack.throttle('api/v1/ip', :limit => 5, :period => 20.seconds) do |req|
  if req.path == 'api/v1/accounts/create' && req.post?
    req.ip
  end

  if req.path == 'api/v1/accounts/login' && req.post?
    req.ip
  end
end