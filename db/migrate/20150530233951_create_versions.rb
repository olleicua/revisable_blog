class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.belongs_to :post, index: true, foreign_key: true, null: false
      t.string :title
      t.text :content
      t.datetime :time

      t.timestamps null: false
    end
  end
end
