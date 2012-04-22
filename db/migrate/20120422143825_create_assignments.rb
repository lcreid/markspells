class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :assigned_by
      t.integer :assigned_to

      t.timestamps
    end
    
    change_table :word_lists do |t|
      t.integer :assignment_id
    end
  end
end
