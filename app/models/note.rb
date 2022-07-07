class Note < ApplicationRecord

  belongs_to :folder

  validates :title, presence: true, length: { minimum: 1, maximum: 128 }  
  
end