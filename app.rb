require "ohm"
require "cuba"
require "json"
require "basica"
require "shield"

Cuba.plugin Shield::Helpers
Cuba.plugin Basica

Cuba.use Rack::Session::Cookie,
  key: ENV.fetch("APP_KEY"),
  secret: ENV.fetch("APP_SECRET")

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

  basic_auth(env) do |user, pass|
    login(User, user, pass)
  end

  on authenticated(User) do
    run Users
  end

  on default do
    res.status = 401
  end
end
