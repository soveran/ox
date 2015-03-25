class Ox
  def initialize(app)
    @app = app
  end

  def auth(user, pass)
    @auth = "Basic %s" % Base64.encode64(sprintf("%s:%s", user, pass))
    true
  end

  def request(path)
    @app.call("SCRIPT_NAME" => "", "PATH_INFO" => path, "HTTP_AUTHORIZATION" => @auth)
  end

  def get(path)
    status, headers, body = request(path)

    [status, body]
  end
end
