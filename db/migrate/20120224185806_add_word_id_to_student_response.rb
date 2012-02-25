class AddWordIdToStudentResponse < ActiveRecord::Migration
  def change
    add_column :student_responses, :word_id, :integer

  end
end
