class Room < ApplicationRecord
  def self.search(search)
    where("number LIKE ?", "%#{search}%")
  end
end
