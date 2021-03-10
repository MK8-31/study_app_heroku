class CreateStudytimes < ActiveRecord::Migration[6.0]
  def change
    create_table :studytimes do |t|
      t.integer :time
      t.integer :ctime
      t.date :day
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
