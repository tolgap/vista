class Website < ActiveRecord::Base
  serialize :website_errors

  attr_accessible :name, :version, :has_update, :blog_name,
    :has_errors, :website_errors, :plugin

  belongs_to :server
  has_many :plugins

  #
  # Sunspot search definition
  #
  searchable do
    text :name, :version, :blog_name
    boolean :has_update
    integer :server_id
  end

  # Instance methods
  def has_plugin_update
    update = false

    self.plugins.each do |plugin|
      if (plugin.status === "active" and plugin.has_update?)
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
