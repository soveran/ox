class Users < Cuba
  def current_user
    authenticated(User)
  end
end

Users.define do
  res.headers["Content-Type"] = "application/json; charset=utf-8"

  on root do
    res.write JSON.dump({ foo: 42 })
  end
end
