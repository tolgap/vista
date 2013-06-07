class HomeController < ApplicationController

  def index
    @servers = Server.all
  end

  def save_all
    wp_server = params[:server]
    data      = params[:data]

    unless Server.exists?(:name => wp_server)
      server = Server.new(name: wp_server)
      server.save!
    else
      server = Server.find_by_name(wp_server)
    end

    data.each do |wp_website|
      core_update = wp_website["has_update"] === "none"
      unless Website.exists?(:name => wp_website["name"], :server_id => server.id)
        website = Website.new(name: wp_website["name"], blog_name: wp_website["blog_name"], has_update: core_update, version: wp_website["version"], server_id: server.id)
      else
        website = Website.where(:name => wp_website["name"], :server_id => server.id).first
        website.version    = wp_website["version"]
        website.has_update = core_update
      end
      
      website.save!

      wp_website["plugins"].each do |plugin|
        plugin_update = plugin["update"] === "available"
        unless Plugin.exists?(:name => plugin["name"], :website_id => website.id)
          plugin = Plugin.new(name: plugin["name"], version: plugin["version"], has_update: plugin_update, status: plugin["status"], website_id: website.id)
        else
          plugin = Plugin.where(:name => plugin["name"], :website_id => website.id).first
          plugin.version    = plugin["version"]
          plugin.status     = plugin["status"]
          plugin.has_update = plugin_update
        end

        plugin.save!
      end
    end

    redirect_to :action => "index"
  end

end
