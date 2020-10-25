class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  # ----- アソシエーション ---------------------------------------------------------------------------------------------
  has_many :tweets
  has_many :likes
  has_many :liked_posts, through: :likes, source: :post
  has_many :messages
  has_many :following_relationships, foreign_key: 'follower_id', class_name: 'FollowRelationship', dependent: :destroy
  has_many :followings, through: :following_relationships
  has_many :follower_relationships, foreign_key: 'following_id', class_name: 'FollowRelationship', dependent: :destroy
  has_many :followers, through: :follower_relationships
  has_many :active_notifications, foreign_key: 'visitor_id', class_name: 'Notification', dependent: :destroy
  has_many :passive_notifications, foreign_key: 'visited_id', class_name: 'Notification', dependent: :destroy
  has_one  :five_km_record
  has_one  :ten_km_record
  has_one  :half_record
  has_one  :full_record

  # ----- Gem関連 ----------------------------------------------------------------------------------------------------
  mount_uploader :image, ImageUploader


  # ----- バリデーション -----------------------------------------------------------------------------------------------
  validates :nickname,     presence: true, length: { maximum: 10 }
  validates :introduction, length: { maximum: 100 }


  # ----- メソッド ----------------------------------------------------------------------------------------------------
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

  # いいねされているか確認
  def liked_by?(tweet_id)
    likes.where(tweet_id: tweet_id).exists?
  end

  # すでにフォロー済みであればtrue返す
  def following?(other_user)
    followings.include?(other_user)
  end

  # ユーザーをフォローする
  def follow(other_user)
    following_relationships.create(following_id: other_user.id)
  end

  # ユーザーのフォローを解除する
  def unfollow(other_user)
    following_relationships.find_by(following_id: other_user.id).destroy
  end

  # フォロー時の通知作成
  def create_notification_follow!(current_user)
    temp = Notification.where(['visitor_id = ? and visited_id = ? and action = ? ', current_user.id, id, 'follow'])
    # 通知がすでに作成されていないか確認（同じユーザーの通知が何度も来ないように）
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
end
