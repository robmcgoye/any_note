class Note < ApplicationRecord

  belongs_to :folder

  validates :title, presence: true, length: { minimum: 1, maximum: 60 }  
  
  default_scope { order(title: :asc) } 

end