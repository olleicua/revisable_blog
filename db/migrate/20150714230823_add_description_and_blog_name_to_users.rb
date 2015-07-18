class AddDescriptionAndBlogNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :description, :text
    add_column :users, :blog_name, :string
  end
end
