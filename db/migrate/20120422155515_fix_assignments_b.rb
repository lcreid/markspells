class FixAssignmentsB < ActiveRecord::Migration
  def change
    change_table :assignments do |t|
      t.rename :assigned_by, :assigned_by_id
      t.rename :assigned_to, :assigned_to_id
    end
  end
end
