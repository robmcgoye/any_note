class Cabinet < ApplicationRecord
  
  belongs_to :account
  
  has_many :folders, dependent: :destroy
  validates :name, presence: true, length: { minimum: 1, maximum: 125 }

end
