class CreateReminders < ActiveRecord::Migration[6.0]
  def change
    create_table :reminders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :notification, null: false, foreign_key: true
      t.integer :action

      t.timestamps
    end
  end
end
