require_relative "helper"

scope do
  prepare do
    Ohm.flush
  end

  setup do
    User.create(email: "user@example.com", password: "monkey")
  end

  test "invalid auth" do |user|
    authorize "some@example.com", "monkey1"
    get "/"

    assert_equal 401, last_response.status
  end

  test "valid auth" do |user|
    authorize "user@example.com", "monkey"
    get "/"

    result = JSON.parse(last_response.body)

    assert_equal result["foo"], 42
  end
end
