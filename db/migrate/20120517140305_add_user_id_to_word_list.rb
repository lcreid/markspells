class AddUserIdToWordList < ActiveRecord::Migration
  def change
    add_column :word_lists, :user_id, :integer
    add_index :word_lists, :user_id

  end
end
