class User < ApplicationRecord
  #attr_accessor :email, :password, :name ,:authority
  before_save { self.email = email.downcase }

end
