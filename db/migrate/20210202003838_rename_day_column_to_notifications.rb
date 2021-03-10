class RenameDayColumnToNotifications < ActiveRecord::Migration[6.0]
  def change
    change_column :notifications, :day, :datetime
    rename_column :notifications, :day,:start_time
  end
end
