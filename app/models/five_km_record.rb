class FiveKmRecord < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :hour

  #空の投稿を保存できないようにする
  validates :hour, presence: true

  #ジャンルの選択が「--」の時は保存できないようにする
  validates :hour_id, numericality: { other_than: 1 } 
end
