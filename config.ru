# Require config/environment.rb
require ::File.expand_path('../config/environment',  __FILE__)

unless development? || test?
  use Rack::Auth::Basic, "Restricted Area" do |username, password|
    username == ENV['HTTP_AUTH_USERNAME'] and password == ENV['HTTP_AUTH_PASSWORD']
  end
end

set :app_file, __FILE__

run Sinatra::Application
