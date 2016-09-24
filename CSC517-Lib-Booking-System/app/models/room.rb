class Room < ApplicationRecord
  where("name LIKE ?", "%#{search}%")
  where("content LIKE ?", "%#{search}%")
end
