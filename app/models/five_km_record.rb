class FiveKmRecord < ApplicationRecord
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :minute
  belongs_to_active_hash :second
  belongs_to :user

end
