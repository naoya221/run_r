class Tweet < ApplicationRecord
  belongs_to :user
  has_many :messages,  dependent: :destroy

  with_options presence: true do 
    validates :content
    validates :prefecture,     null: false
    validates :city,           null: false
    validates :place_name,     null: false
    validates :place_image,    null: false
    validates :user
  end

end
