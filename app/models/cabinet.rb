class Cabinet < ApplicationRecord
  
  belongs_to :account
  has_many :folders, dependent: :destroy
  
  accepts_nested_attributes_for :folders

  validates :name, presence: true, uniqueness: true, length: { minimum: 1, maximum: 45 }

end
