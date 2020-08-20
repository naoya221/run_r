class TenKmRecord < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :hour
  belongs_to_active_hash :minute
  belongs_to_active_hash :second
  belongs_to :user  

  validates :user, uniqueness: true
  
end
