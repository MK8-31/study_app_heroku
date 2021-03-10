class CreateSubjects < ActiveRecord::Migration[6.0]
  def change
    create_table :subjects do |t|
      t.string :name
      t.string :day_of_week
      t.integer :th_period
      t.boolean :definitely
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :subjects,[:day_of_week,:th_period],unique: true
  end
end
