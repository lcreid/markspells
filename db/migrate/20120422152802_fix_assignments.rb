class FixAssignments < ActiveRecord::Migration
  def change
    change_table :assignments do |t|
      t.integer :word_list_id
    end
    
    change_table :word_lists do |t|
      t.remove :assignment_id
    end
  end
end
