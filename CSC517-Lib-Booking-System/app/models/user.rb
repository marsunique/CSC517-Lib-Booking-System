class User < ApplicationRecord
  #attr_accessor :email, :password, :name ,:authority
  before_save { self.email = email.downcase }
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password

end
