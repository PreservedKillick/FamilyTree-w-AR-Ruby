class Couple < ActiveRecord::Base
  has_many(:people)
end
