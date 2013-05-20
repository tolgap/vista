class Server < ActiveRecord::Base
  attr_accessible :name
  has_many :websites
end
