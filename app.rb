require "ohm"
require "cuba"
require "json"
require "shield"
require "basica"

Ohm.redis = Redic.new(ENV.fetch("REDIS_URL"))

Cuba.plugin Basica

# Require all application files.
Dir["./models/**/*.rb"].each  { |rb| require rb }
Dir["./routes/**/*.rb"].each  { |rb| require rb }

# Require all helper files.
Dir["./helpers/**/*.rb"].each { |rb| require rb }
Dir["./filters/**/*.rb"].each { |rb| require rb }

Cuba.use Rack::MethodOverride

Cuba.define do
  on env["HTTP_AUTHORIZATION"].nil? do
    res.status = 401
    res.headers["WWW-Authenticate"] = 'Basic realm="MyApp"'
    res.write "Unauthorized"
  end

  user = nil

  basic_auth(env) do |username, password|
    user = User.authenticate(username, password)
  end

  on user.nil? do
    res.status = 401
  end

  on default do
    with(user: user) do
      run Users
    end
  end
end
