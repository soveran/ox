class Users < Cuba
end

Users.define do
  res.headers["Content-Type"] = "application/json"
  user = vars[:user]

  on root do
    res.write JSON.dump({ foo: 42 })
  end

  on "foo" do
    on root do
      res.write JSON.dump({ foo: 23 })
    end
  end
end
