class CreateChildParents < ActiveRecord::Migration
  def change
    create_table :child_parents do |t|
      t.integer :child_id
      t.integer :parent_id

      t.timestamps
    end
    
    add_index :child_parents, :child_id
    add_index :child_parents, :parent_id
  end
end
