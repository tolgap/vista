class Website < ActiveRecord::Base
  attr_accessible :name, :version, :server_id
  belongs_to :server
  has_many :plugins

  # Class methods
  class << self

    def has_plugin(plugin)
      matches = Plugin.where(:name => plugin.name).all
    end

  end
end
