class HalfRecord < ApplicationRecord
  # ----- アソシエーション ---------------------------------
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :hour
  belongs_to_active_hash :minute
  belongs_to_active_hash :second
  belongs_to :user


  # ----- バリデーション ----------------------------------
  with_options presence: true do
    validates :hour_id
    validates :minute_id
    validates :second_id
    validates :user
  end
end
