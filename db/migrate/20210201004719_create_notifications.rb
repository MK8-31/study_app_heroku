class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.string :subject
      t.date :day
      t.boolean :homework_test
      t.boolean :over
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :notifications, [:user_id, :day]
  end
end
