class Plugin < ActiveRecord::Base
  attr_accessible :name, :status, :has_update, :version
  belongs_to :website

  #
  # Sunspot search definition
  #
  searchable do
    text :name, :version, :status
    boolean :has_update
  end

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
