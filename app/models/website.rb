class Website < ActiveRecord::Base
  attr_accessible :name, :version, :blog_name, :server_id
  belongs_to :server
  has_many :plugins

  #
  # ElasticSearch definition
  #
  # include Tire::Model::Search
  # include Tire::Model::Callbacks
  # after_touch() { tire.update_index }

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

    def check_latest_wp_version
      require "net/http"
      require "php_serialize"
      url = URI.parse('http://api.wordpress.org/core/version-check/1.6')
      r = Net::HTTP.get_response(url)
      if r.code == "301"
          url = URI.parse(r.header['location'])
      end

      req = Net::HTTP::Get.new(url.path)
      res = Net::HTTP.start(url.host, url.port) {|http|
        http.request(req)
      }

      result = PHP.unserialize(res.body)
      result['offers'].first['current']
    end

  end
end
