class AddPracticeSessionIdToStudentResponse < ActiveRecord::Migration
  def change
    add_column :student_responses, :practice_session_id, :integer

  end
end
