class User < ApplicationRecord
  # password入力なしでプロフィール変更できる
  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :image, ImageUploader

  has_many :tweets
  has_many :messages
  has_one :five_km_record
  has_one :ten_km_record
  has_one :half_record
  has_one :full_record

  validates :nickname, presence: true, length: { maximum: 10 }
end
