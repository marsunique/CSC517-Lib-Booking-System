class Room < ApplicationRecord
  validates_inclusion_of :size,:in => %w{ 4 6 12 }
  validates_inclusion_of :building,:in => %w{James.B.Hunt D.H.Hill}
  validates :number, presence: true
  validates :size, presence: true
  validates :building, presence: true

  def self.search(search)
    where("number LIKE ?", "%#{search}%")
    where("size LIKE ?", "%#{search}%")
    #where("building LIKE ?", "%#{search}%")
  end
end
