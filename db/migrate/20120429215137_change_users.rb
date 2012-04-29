class ChangeUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :user_guid, :string
    
    rename_column :practice_sessions, :old_user_id, :user_id
    rename_column :student_responses, :old_user_id, :user_id
  end
  
  def up
  end

  def down
  end
end
