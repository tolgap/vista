class AddCmsTypeToWebsites < ActiveRecord::Migration
  def change
    add_column :websites, :cms_type, :string, default: 'wordpress'
  end
end
