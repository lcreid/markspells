class AddGuidToUser < ActiveRecord::Migration
  def change
    add_column :users, :user_guid, :string

  end
end
