class Message < ApplicationRecord
  belongs_to :tweet
  belongs_to :user
  has_many :notifications, dependent: :destroy

  with_options presence: true do
    validates :text
    validates :user
    validates :tweet
  end
end
