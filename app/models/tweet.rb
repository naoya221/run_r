class Tweet < ApplicationRecord
  belongs_to :user
  has_many :messages,  dependent: :destroy

  with_options presence: true do 
    validates :content
    validates :user
  end

end
