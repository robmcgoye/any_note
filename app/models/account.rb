class Account < ApplicationRecord
  validates :name, presence: true, length: { minimum: 1, maximum: 125 }
  
  has_many :users, dependent: :destroy
  accepts_nested_attributes_for :users

  has_many :cabinets, dependent: :destroy

  def registered_owner
    users.where(owner: true).take
  end

end