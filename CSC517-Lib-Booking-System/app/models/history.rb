class History < ApplicationRecord
  validates_inclusion_of :building,:in => %w{James.B.Hunt D.H.Hill}
  validates_inclusion_of :begintime,:in => %w{0 2 4 6 8 10 12 14 16 18 20 22}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :number, presence: true
  validates :building, presence: true
  validates :email, presence: true, length: {maximum: 255},
            format: {with: VALID_EMAIL_REGEX},
            case_sensitive: false
  validates :date, presence: true
  validates :begintime, presence: true
end
