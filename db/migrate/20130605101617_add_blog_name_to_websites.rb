class AddBlogNameToWebsites < ActiveRecord::Migration
  def change
    change_table :websites do |t|
      t.string :blog_name
    end
  end
end
