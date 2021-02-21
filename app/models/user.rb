class User < ActiveRecord::Base
  has_secure_password

  def self.create_if_empty(name, password)
    return User.create(name: name, password: password) if User.count == 0
    User.find_by(name: name)
  end
end
