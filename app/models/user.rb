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
  has_many :likes
  has_many :liked_posts, through: :likes, source: :post
  has_many :messages
  has_one :five_km_record
  has_one :ten_km_record
  has_one :half_record
  has_one :full_record

  has_many :following_relationships,foreign_key: "follower_id", class_name: "FollowRelationship",  dependent: :destroy
  has_many :followings, through: :following_relationships
  has_many :follower_relationships,foreign_key: "following_id",class_name: "FollowRelationship", dependent: :destroy
  has_many :followers, through: :follower_relationships

  validates :nickname, presence: true, length: { maximum: 10 }

  def liked_by?(tweet_id)
    likes.where(tweet_id: tweet_id).exists?
  end

  #すでにフォロー済みであればtrue返す
  def following?(other_user)
    self.followings.include?(other_user)
  end

  #ユーザーをフォローする
  def follow(other_user)
    self.following_relationships.create(following_id: other_user.id)
  end

  #ユーザーのフォローを解除する
  def unfollow(other_user)
    self.following_relationships.find_by(following_id: other_user.id).destroy
  end
end
