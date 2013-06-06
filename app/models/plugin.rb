class Plugin < ActiveRecord::Base
  attr_accessible :name, :status, :updates, :version, :website_id
  belongs_to :website

  #
  # ElasticSearch definition
  #
  # include Tire::Model::Search
  # include Tire::Model::Callbacks
  # after_touch() { tire.update_index }

  # class methods
  class << self

  	def get_wp_plugin_info(plugin)
  		require "net/http"
  		require "php_serialize"

  		uri = URI.parse("http://api.wordpress.org/plugins/info/1.0/" + plugin.name)
  		res = Net::HTTP.get(uri)
			
			result = PHP.unserialize(res)
      if result.nil?
        false
      else
        result
      end
      
  	end

  end
end
