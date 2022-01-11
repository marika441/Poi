class Declutter < ApplicationRecord
  
  belongs_to :user
  attachment :thing_image
  
end