class CreateStudentResponses < ActiveRecord::Migration
  def change
    create_table :student_responses do |t|
      t.string :word
      t.string :student_response
			t.text :sentence
      t.string :action
      t.boolean :correct

      t.timestamps
    end
  end
end
