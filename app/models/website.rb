class Website < ActiveRecord::Base
  attr_accessible :name, :version, :server_id
  belongs_to :server
  has_many :plugins
end
