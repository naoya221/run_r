class Message < ApplicationRecord
  belongs_to :tweet
  belongs_to :user

  with_options presence: true do
    validates :text
    validates :user
    validates :tweet
  end
end
