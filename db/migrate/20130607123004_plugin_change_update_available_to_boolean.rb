class PluginChangeUpdateAvailableToBoolean < ActiveRecord::Migration
  def up
    remove_column :plugins, :updates

    change_table :plugins do |t|
      t.boolean :has_update
    end
  end

  def down
  end
end
