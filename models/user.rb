class User < Ohm::Model
  include Shield::Model

  attribute :email
  attribute :crypted_password

  unique :email

  def self.fetch(email)
    with(:email, email)
  end
end
