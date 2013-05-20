class Plugin < ActiveRecord::Base
  attr_accessible :name, :status, :updates, :version, :website_id
  belongs_to :website
end
