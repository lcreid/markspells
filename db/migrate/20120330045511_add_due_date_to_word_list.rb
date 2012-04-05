class AddDueDateToWordList < ActiveRecord::Migration
  def change
    add_column :word_lists, :due_date, :date
  end
end
