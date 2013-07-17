class HomeController < ApplicationController

  def index
    @servers = Server.all
  end

  def save_all
    wp_server = params[:server]
    data      = params[:data]

    server = save_server(wp_server)

    Website.transaction do
      data.each do |wp_website|
        website = save_website(wp_website, server)

        next if wp_website["plugins"].nil?

        Plugin.transaction do
          wp_website["plugins"].each do |wp_plugin|
            plugin = save_plugin(wp_plugin, website)
          end
        end
        
      end
    end

    redirect_to :action => "index"
  end

  private

  def save_server(wp_server)
    unless Server.exists?(:name => wp_server)
      server = Server.new(name: wp_server)
    else
      server = Server.find_by_name(wp_server)
    end
    server.touch
    server.save!

    server
  end

  def save_website(wp_website, server)
    core_update = wp_website["has_update"] === "none"
    unless Website.exists?(:name => wp_website["name"], :server_id => server.id)
      website = Website.new(name: wp_website["name"], blog_name: wp_website["blog_name"], has_update: core_update, version: wp_website["version"], server_id: server.id, has_errors: wp_website["has_errors"])
    else
      website = Website.where(:name => wp_website["name"], :server_id => server.id).first
      website.has_update     = core_update
      website.version        = wp_website["version"]
      website.has_errors     = wp_website["has_errors"]
      website.website_errors = wp_website["website_errors"]
    end
    
    website.touch
    website.save!

    website
  end

  def save_plugin(wp_plugin, website)
    plugin_update = wp_plugin["update"] === "available"
    unless Plugin.exists?(:name => wp_plugin["name"], :website_id => website.id)
      plugin = Plugin.new(name: wp_plugin["name"], version: wp_plugin["version"], has_update: plugin_update, status: wp_plugin["status"], website_id: website.id)
    else
      plugin = Plugin.where(:name => wp_plugin["name"], :website_id => website.id).first
      plugin.version    = wp_plugin["version"]
      plugin.status     = wp_plugin["status"]
      plugin.has_update = plugin_update
    end

    plugin.touch
    plugin.save!

    plugin
  end
end
