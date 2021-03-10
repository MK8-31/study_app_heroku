class Subject < ApplicationRecord
  belongs_to :user
  validates :name,presence: true,length: { maximum: 20 }
  validates :day_of_week,presence: true,length: { maximum: 10 }
  validates :th_period,presence: true,inclusion: { in: 1..6 },uniqueness: { scope: [:day_of_week,:user_id]}
  validates :user_id,presence: true
end
