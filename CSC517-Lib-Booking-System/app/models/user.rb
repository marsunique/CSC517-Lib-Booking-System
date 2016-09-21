class User < ApplicationRecord
  #attr_accessor :email, :password, :name ,:authority
  before_save { self.email = email.downcase }
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost) end

end
