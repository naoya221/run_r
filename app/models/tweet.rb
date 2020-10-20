class Tweet < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :destroy
  has_many :likes
  has_many :liked_users, through: :likes, source: :user
  has_many :tag_tweets, dependent: :destroy
  has_many :tags, through: :tag_tweets
  has_many :notifications, dependent: :destroy

  mount_uploader :place_image, ImageUploader
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

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

  def save_tags(save_tweet_tags)
    current_tags = tags.pluck(:name) unless tags.nil?
    old_tags = current_tags - save_tweet_tags
    new_tags = save_tweet_tags - current_tags

    old_tags.each do |old_name|
      tags.delete Tag.find_by(name: old_name)
    end

    new_tags.each do |new_name|
      tweet_tag = Tag.find_or_create_by(name: new_name)
      tags << tweet_tag
    end
  end

  def get_length
    @likes = likes.length
    @messages = messages.length
  end

  def create_notification_like!(current_user)
    temp = Notification.where(['visitor_id = ? and visited_id = ? and tweet_id = ? and action = ? ',
                               current_user.id, user_id, id, 'like'])
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

  def create_notification_message!(current_user, message_id)
    # 同じ投稿にコメントしているユーザーに通知を送る。（current_userと投稿ユーザーのぞく）
    temp_ids = Message.where(tweet_id: id).where.not('user_id=? or user_id=?', current_user.id, user_id).select(:user_id).distinct
    # 取得したユーザー達へ通知を作成。（user_idのみ繰り返し取得）
    temp_ids.each do |temp_id|
      save_notification_message!(current_user, message_id, temp_id['user_id'])
    end
    # 投稿者へ通知を作成
    save_notification_message!(current_user, message_id, user_id)
  end

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

  with_options presence: true do
    validates :place_name,     null: false, length: { maximum: 16 }
    validates :place_image,    null: false
    validates :content,        null: false,   length: { maximum: 100 }
    validates :address,        null: false,   length: { maximum: 30 }
    validates :user
    validates :level
  end
end
