class CreateListItems < ActiveRecord::Migration
  def change
    create_table :list_items do |t|
      t.string :word
      t.text :sentence

      t.timestamps
    end
  end
end
