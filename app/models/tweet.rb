class Tweet < ApplicationRecord
  belongs_to :user
  has_many :messages,  dependent: :destroy

  mount_uploader :place_image, ImageUploader
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  with_options presence: true do 
    validates :content,        null: false
    validates :address,        null: false
    validates :place_name,     null: false
    validates :place_image,    null: false
    validates :user
  end

end
