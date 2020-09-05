class Tweet < ApplicationRecord

  belongs_to :user
  has_many :messages,  dependent: :destroy

  mount_uploader :place_image, ImageUploader
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  with_options presence: true do 
    validates :place_name,     null: false,   length: { maximum: 16 }
    validates :place_image,    null: false
    validates :content,        null: false,   length: { maximum: 100 }
    validates :address,        null: false,   length: { maximum: 30 }
    validates :user
  end

end
