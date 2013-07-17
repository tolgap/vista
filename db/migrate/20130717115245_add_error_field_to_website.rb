class AddErrorFieldToWebsite < ActiveRecord::Migration
  def change
    add_column :websites, :has_errors, :boolean, default: false
  end
end
