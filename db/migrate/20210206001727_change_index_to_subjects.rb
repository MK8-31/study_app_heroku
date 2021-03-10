class ChangeIndexToSubjects < ActiveRecord::Migration[6.0]
  def up
    remove_index :subjects,[:day_of_week,:th_period]
    add_index :subjects,[:day_of_week,:th_period,:user_id],unique: true
  end
end
