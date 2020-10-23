class Like < ApplicationRecord
  # ----- アソシエーション ------
  belongs_to :user
  belongs_to :tweet
end
