class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }

  # ----- アソシエーション -----------------------------------
    belongs_to :visitor, class_name: 'User', optional: true
    belongs_to :visited, class_name: 'User', optional: true
    belongs_to :tweet, optional: true
    belongs_to :message, optional: true


  # ----- バリデーション ------------------------------------
    with_options presence: true do
      validates :visitor_id
      validates :visited_id
      validates :action,  inclusion: { in: ACTION_VALUES }
      validates :checked, inclusion: { in: [true, false] }
    end
    ACTION_VALUES = %w[like follow message].freeze
end
