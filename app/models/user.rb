class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tweets
  has_many :messages
  has_one :five_km_record
  has_one :ten_km_record
  has_one :half_record
  has_one :full_record

  validates :nickname, presence: true, length: { maximum: 10 }
  
end
