class AddReferencesToModels < ActiveRecord::Migration
  def change
    change_table :websites do |t|
      t.references :server
    end

    change_table :plugins do |t|
      t.references :websites
    end
  end
end
