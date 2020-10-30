class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  ACTION_VALUES = %w[like follow message].freeze

  # ----- アソシエーション -----------------------------------
    belongs_to :visitor, class_name: 'User', optional: true
    belongs_to :visited, class_name: 'User', optional: true
    belongs_to :tweet, optional: true
    belongs_to :message, optional: true


  # ----- バリデーション ------------------------------------
    # with_options presence: true do
      validates :visitor_id
      validates :visited_id
      validates :checked, inclusion: { in: [true, false] }
    # end
    #  ACTION_VALUESを適用するため、上記ブロックから出す
    validates :action, presence: true, inclusion: { in: ACTION_VALUES }
end
