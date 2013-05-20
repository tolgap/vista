class ChangePluginsUpdateToUpdates < ActiveRecord::Migration
  def up
  	rename_column :plugins, :update, :updates
  end

  def down
  end
end
