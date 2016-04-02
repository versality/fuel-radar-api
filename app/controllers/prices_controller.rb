require 'json'
require 'rack-cache'

use Rack::Cache

get '/prices' do
  cache_control :public, max_age: 60 * 5 # every 5 minutes

  content_type :json

  prices = [
    Neste.new.prices,
    Statoil.new.prices
  ]

  prices.inject(&:merge).to_json
end
