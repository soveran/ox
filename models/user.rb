class User < Ohm::Model
  include Shield::Model

  attribute :username
  attribute :crypted_password

  unique :username

  def self.fetch(username)
    with(:username, username)
  end
end
