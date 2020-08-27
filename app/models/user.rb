class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tweets,  dependent: :destroy
  has_many :messages,  dependent: :destroy
  has_one :five_km_record,  dependent: :destroy
  has_one :ten_km_record,  dependent: :destroy
  has_one :half_record,  dependent: :destroy
  has_one :full_record,  dependent: :destroy
  
end
