class AddGuidToOldUser < ActiveRecord::Migration
  def change
    add_column :old_users, :user_guid, :string

  end
end
