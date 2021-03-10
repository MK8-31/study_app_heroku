class Notification < ApplicationRecord
  MAX_NOTICE_COUNT = 50
  belongs_to :user
  has_one :reminder, dependent: :destroy
  validates :subject,presence: true,length: {maximum: 20 }
  validates :start_time,presence: true
  validate :notification_count_must_be_within_limit

  private

    def notification_count_must_be_within_limit
      errors.add(:base, "ユーザー１人当たりの持てる予定の数: #{MAX_NOTICE_COUNT}") if user.notifications.where(over: false).count > MAX_NOTICE_COUNT
      #errors.add(:base, "ユーザー１人当たりの持てる予定の数: #{MAX_NOTICE_COUNT}") if user.posts.count >= MAX_NOTICE_COUNT
    end

end
