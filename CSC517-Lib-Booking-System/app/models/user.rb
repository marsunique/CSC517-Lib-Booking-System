class User < ApplicationRecord
  #attr_accessor :email, :password, :name ,:authority
  before_save { self.email = email.downcase }
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :name, presence: true
  validates :authority, presence: true
  has_secure_password

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost) end

end
