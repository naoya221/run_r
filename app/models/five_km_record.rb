class FiveKmRecord < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :hour
  belongs_to :user  

  validates :user, uniqueness: true
  validates :hour, presence: true
  validates :hour_id, numericality: { other_than: 1 } 
  
end
