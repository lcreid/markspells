class AddWordOrderToListItem < ActiveRecord::Migration
  def change
    add_column :list_items, :word_order, :integer

  end
end
