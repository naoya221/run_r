class Message < ApplicationRecord
  # ----- アソシエーション ------------------------
  has_many   :notifications, dependent: :destroy
  belongs_to :tweet
  belongs_to :user


  # ----- バリデーション --------------------------
  with_options presence: true do
    validates :text
    validates :user
    validates :tweet
  end
end
