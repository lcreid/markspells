class CreatePracticeSessions < ActiveRecord::Migration
  def change
    create_table :practice_sessions do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :user_id
      t.integer :word_list_id

      t.timestamps
    end
  end
end
