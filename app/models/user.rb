class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  belongs_to :account

  validates :first_name, presence: true, length: { minimum: 1, maximum: 125 }
  validates :last_name, presence: true, length: { minimum: 1, maximum: 125 }

  default_scope { order(title: :asc) } 

  def full_name
    "#{first_name.upcase_first} #{last_name.upcase_first}"
  end

end
