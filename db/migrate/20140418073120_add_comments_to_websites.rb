class AddCommentsToWebsites < ActiveRecord::Migration
  def change
    add_column :websites, :comments, :text
  end
end
