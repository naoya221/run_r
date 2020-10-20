class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :visitor, class_name: 'User', optional: true
  belongs_to :visited, class_name: 'User', optional: true
  belongs_to :tweet, optional: true
  belongs_to :message, optional: true

  validates :visitor_id, presence: true
  validates :visited_id, presence: true

  ACTION_VALUES = %w[like follow message].freeze
  validates :action,  presence: true, inclusion: { in: ACTION_VALUES }
  validates :checked, inclusion: { in: [true, false] }
end
