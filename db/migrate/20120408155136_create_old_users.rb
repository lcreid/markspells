class CreateOldUsers < ActiveRecord::Migration
  def change
    create_table :old_users do |t|
      t.string :name

      t.timestamps
    end
  end
end
