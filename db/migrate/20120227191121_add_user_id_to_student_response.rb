class AddUserIdToStudentResponse < ActiveRecord::Migration
  def change
    add_column :student_responses, :old_user_id, :integer

  end
end
