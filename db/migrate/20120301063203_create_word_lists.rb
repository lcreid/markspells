class CreateWordLists < ActiveRecord::Migration
  def change
    create_table :word_lists do |t|

      t.timestamps
    end
  end
end
