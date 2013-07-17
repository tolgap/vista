class AddPhpErrorFieldsToWebsite < ActiveRecord::Migration
  def change
    add_column :websites, :website_errors, :text
  end
end
