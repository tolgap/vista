class FixTypoAtReference < ActiveRecord::Migration
  def up
  	rename_column :plugins, :websites_id, :website_id
  end

  def down
  end
end
