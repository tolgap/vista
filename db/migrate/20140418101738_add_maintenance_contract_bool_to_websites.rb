class AddMaintenanceContractBoolToWebsites < ActiveRecord::Migration
  def change
    add_column :websites, :has_maintenance, :boolean, default: true
  end
end
