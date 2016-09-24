class Room < ApplicationRecord
  def self.search(search)
    where("number LIKE ?", "%#{search}%")
    where("size LIKE ?", "%#{search}%")
    #where("building LIKE ?", "%#{search}%")
  end
end
