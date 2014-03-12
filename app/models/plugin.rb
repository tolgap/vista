class Plugin < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  attr_accessible :name, :status, :has_update, :version
  belongs_to :website

  mapping do
    indexes :name, analyzer: 'snowball'
    indexes :version, analyzer: 'snowball'
    indexes :has_update, type: :boolean
    indexes :status
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
