class Tag < ApplicationRecord
  has_many   :tag_tweets, dependent: :destroy
  has_many   :tweets, through: :tag_tweets

  validates :name, uniqueness: true
end
