class TenKmRecord < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :minute
  belongs_to_active_hash :second
  belongs_to :user

  with_options presence: true do
    validates :minute_id
    validates :second_id
    validates :user
  end
end
