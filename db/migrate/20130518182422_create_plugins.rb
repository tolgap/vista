class CreatePlugins < ActiveRecord::Migration
  def change
    create_table :plugins do |t|
      t.string :name
      t.string :status
      t.string :update
      t.string :version

      t.timestamps
    end
  end
end
