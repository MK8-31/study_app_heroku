class Studytime < ApplicationRecord
  belongs_to :user
  default_scope -> { order(day: :asc)}
  validates :day,presence: true,uniqueness: { scope: :user_id }
  validates :time,presence: true,numericality: { only_integer: true }

  with_options if: :time.presence do
    validates :ctime,presence: true,numericality: { only_integer: true,less_than_or_equal_to: :time }
  end
  
end
