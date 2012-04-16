class AddTitleToWordList < ActiveRecord::Migration
  def change
    add_column :word_lists, :title, :string

  end
end
