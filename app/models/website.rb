class Website < ActiveRecord::Base
  attr_accessible :name, :version, :blog_name, :server_id
  belongs_to :server
  has_many :plugins

  # Instance methods
  def has_update
    update = false

    self.plugins.each do |plugin|
      if (plugin.status === "active" and plugin.updates === "available")
        update = true
        break
      end
    end
    
    update
  end

  # Class methods
  class << self

    def has_plugin(plugin)
      matches = Plugin.where(:name => plugin.name).all
    end

  end
end
