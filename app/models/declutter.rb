class Declutter < ApplicationRecord
  
  belongs_to :user
  has_many :declutter_comments, dependent: :destroy
  attachment :thing_image
  
end