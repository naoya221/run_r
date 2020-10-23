class Tag < ApplicationRecord
  # ----- アソシエーション ---------------------
  has_many   :tag_tweets, dependent: :destroy
  has_many   :tweets, through: :tag_tweets


  # ----- バリデーション -----------------------
  validates :name, uniqueness: true
end
