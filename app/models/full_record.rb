class FullRecord < ApplicationRecord
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :hour
  belongs_to_active_hash :minute
  belongs_to :user  

  validates :user, uniqueness: true
  
end
