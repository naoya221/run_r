class Tweet < ApplicationRecord
  # ----- アソシエーション ----------------------------------------------
  has_many   :messages, dependent: :destroy
  has_many   :likes, dependent: :destroy
  has_many   :liked_users, through: :likes, source: :user
  has_many   :tag_tweets, dependent: :destroy
  has_many   :tags, through: :tag_tweets
  has_many   :notifications, dependent: :destroy
  belongs_to :user


  # ----- Gem関連 -----------------------------------------------------
  mount_uploader   :place_image, ImageUploader
  geocoded_by      :address
  after_validation :geocode, if: :address_changed?


  # -----バリデーション ------------------------------------------------
  with_options presence: true do
    validates :place_name,     null: false, length: { maximum: 16 }
    validates :place_image,    null: false
    validates :content,        null: false,   length: { maximum: 100 }
    validates :address,        null: false,   length: { maximum: 30 }
    validates :user
    validates :level
  end


  # ----- メソッド -----------------------------------------------------
  # 検索対象のカラムを設定。入力無しなら全て表示
  def self.search(search)
    if search != ''
      Tweet
        .where('place_name LIKE(?)', "%#{search}%")
        .or(Tweet.where('address LIKE(?)', "%#{search}%"))
        .or(Tweet.where('content LIKE(?)', "%#{search}%"))
    else
      Tweet.all
    end
  end

  # タグを保存する処理
  def save_tags(save_tweet_tags)
    current_tags = tags.pluck(:name) unless tags.nil?
    # 新・古タグをそれぞれ取得
    old_tags = current_tags - save_tweet_tags
    new_tags = save_tweet_tags - current_tags

    # 古いタグの削除
    old_tags.each do |old_name|
      tags.delete Tag.find_by(name: old_name)
    end

    # 新しいタグの保存
    new_tags.each do |new_name|
      tweet_tag = Tag.find_or_create_by(name: new_name)
      tags << tweet_tag
    end
  end

  # いいね・コメント数の取得
  def get_length
    @likes = likes.length
    @messages = messages.length
  end

  # いいねの通知作成
  def create_notification_like!(current_user)
    temp = Notification.where(['visitor_id = ? and visited_id = ? and tweet_id = ? and action = ? ',
                               current_user.id, user_id, id, 'like'])
    # 通知がすでに作成されていないか確認（同じ投稿へ通知が何度も来ないように）
    if temp.blank?
      notification = current_user.active_notifications.new(
        tweet_id: id,
        visited_id: user_id,
        action: 'like'
      )

      notification.checked = true if notification.visitor_id == notification.visited_id
      notification.save if notification.valid?
    end
  end

  # コメントの通知作成
  def create_notification_message!(current_user, message_id)
    def save_notification_message!(current_user, message_id, visited_id)
      notification = current_user.active_notifications.new(
        tweet_id: id,
        message_id: message_id,
        visited_id: visited_id,
        action: 'message'
      )
      notification.checked = true if notification.visitor_id == notification.visited_id
      notification.save if notification.valid?
    end
   save_notification_message!(current_user, message_id, user_id)
  end
end
