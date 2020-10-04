class CreateFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :friends do |t|
      t.references :user, foreign_key: true
      t.integer :friend_id, null: false

      t.timestamps
    end
  end
end
