require_relative "helper"

EXAMPLE = {
  username: "sample",
  password: "monkey",
}

scope do
  prepare do
    Ohm.flush
    User.create(EXAMPLE)
  end

  setup do
    Ox.new(Cuba)
  end

  test "invalid auth" do |ox|
    ox.auth("sample", "wrongpass")

    status, body = ox.get("/")

    assert_equal 401, status
  end

  test "valid auth" do |ox|
    ox.auth(EXAMPLE[:username], EXAMPLE[:password])

    status, body = ox.get("/")

    result = JSON.parse(body.join)

    assert_equal 200, status
    assert_equal 42, result["foo"]
  end
end

scope do
  test "sub app" do
    ox = Ox.new(Users)

    status, body = ox.get("/")

    result = JSON.parse(body.join)

    assert_equal 200, status
    assert_equal 42, result["foo"]

    status, body = ox.get("/foo")

    result = JSON.parse(body.join)

    assert_equal 200, status
    assert_equal 23, result["foo"]
  end
end
