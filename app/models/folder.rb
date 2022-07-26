class Folder < ApplicationRecord
  
  belongs_to :cabinet, optional: true
  has_many :notes, dependent: :destroy
  
  has_many :subfolders, class_name: "Folder", foreign_key: "subfolder_id", dependent: :destroy
  belongs_to :subfolder, class_name: "Folder", optional: true

  validates :title, presence: true, length: { minimum: 1, maximum: 25 }  

  default_scope { order(title: :asc) } 
  
end