class Reminder < ApplicationRecord
  default_scope -> { order(created_at: :desc)}
  belongs_to :user
  belongs_to :notification
  validates :action,presence: true
  enum action: { warning: 1, expired: 2}
end
