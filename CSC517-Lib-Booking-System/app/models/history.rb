class History < ApplicationRecord
  validates_inclusion_of :building,:in => %w{James.B.Hunt D.H.Hill}
  validates_inclusion_of :begintime,:in => %w{0 2 4 6 8 10 12 14 16 18 20 22}


end
