class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
  
  has_many :hotels, dependent: :destroy    
  has_many :bookings, dependent: :destroy   
  has_many :payments, dependent: :destroy

  VALID_ROLES = %w[host guest]

  validates :role, inclusion: {in: VALID_ROLES}
end
