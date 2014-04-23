class AddHasMailToServer < ActiveRecord::Migration
  def change
    add_column :servers, :has_mail, :boolean, default: false
  end
end
