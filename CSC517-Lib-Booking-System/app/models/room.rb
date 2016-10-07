class Room < ApplicationRecord
  validates_inclusion_of :size,:in => %w{ 4 6 12 }
  validates_inclusion_of :building,:in => %w{James.B.Hunt D.H.Hill}
  validates :number, presence: true
  validates :size, presence: true
  validates :building, presence: true
  has_many :history

  def self.search(number, size, building)
      if number != '' && size == '' && building == ''
        where("number LIKE ?", "%#{number}%")
      elsif number != '' && size == '' && building != ''
        where("number LIKE ?", "%#{number}%").where("building LIKE ?", "%#{building}%")
      elsif number != '' && size != '' && building == ''
        where("number LIKE ?", "%#{number}%").where("size LIKE ?", "%#{size}%")
      elsif number != '' && size != '' && building != ''
        where("number LIKE ?", "%#{number}%").where("size LIKE ?", "%#{size}%").where("building LIKE ?", "%#{building}%")
      elsif number == '' && size == '' && building != ''
        where("building LIKE ?", "%#{building}%")
      elsif number == '' && size != '' && building == ''
        where("size LIKE ?", "%#{size}%")
      elsif number == '' && size != '' && building != ''
        where("size LIKE ?", "%#{size}%").where("building LIKE ?", "%#{building}%")
      end
      #if building != ''
       # where("building LIKE ?", "%#{building}%")
      #end
  end

  def self.searchSize(search)
    where("size LIKE ?", "%#{search}%")
  end
end
