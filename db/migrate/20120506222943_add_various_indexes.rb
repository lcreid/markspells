class AddVariousIndexes < ActiveRecord::Migration
  def change
    add_index :practice_sessions, :user_id
    add_index :practice_sessions, :word_list_id
    
    add_index :assignments, :assigned_to_id
    add_index :assignments, :assigned_by_id
    add_index :assignments, :word_list_id
    
    add_index :student_responses, :user_id
    add_index :student_responses, :practice_session_id
    add_index :student_responses, :word_id
    
    add_index :list_items, :word_list_id
  end
end
