class AddIndexToStudytimes < ActiveRecord::Migration[6.0]
  def change
    add_index :studytimes,[:day,:user_id],unique: true
  end
end
