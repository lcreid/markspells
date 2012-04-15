class AddStartTimeAndEndTimeToStudentResponse < ActiveRecord::Migration
  def change
    add_column :student_responses, :start_time, :datetime
    add_column :student_responses, :end_time, :datetime

  end
end
