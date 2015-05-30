class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.belongs_to :user, index: true, foreign_key: true, null: false
      t.integer :parent_id, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
