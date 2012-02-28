class AddUserIdToStudentResponse < ActiveRecord::Migration
  def change
    add_column :student_responses, :user_id, :integer

  end
end
