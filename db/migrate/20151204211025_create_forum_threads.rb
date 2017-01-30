class CreateForumThreads < ActiveRecord::Migration
  def change
    create_table :forum_threads do |t|
      t.integer :user_id
      t.string :title

      t.timestamps null: false
    end
  end
end
