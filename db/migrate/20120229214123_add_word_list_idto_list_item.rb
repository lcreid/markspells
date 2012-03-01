class AddWordListIdtoListItem < ActiveRecord::Migration
  def change
    add_column :list_items, :word_list_id, :integer

  end
end
