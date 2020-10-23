class TagTweet < ApplicationRecord
  # ----- アソシエーション ----------
  belongs_to :tweet
  belongs_to :tag
end
