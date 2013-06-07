class AddUpdateIndicationToWebsites < ActiveRecord::Migration
  def change
    change_table :websites do |t|
      t.boolean :has_update
    end
  end
end
