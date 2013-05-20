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
      unless Website.exists?(:name => wp_website["name"], :server_id => server.id)
        website = Website.new(name: wp_website["name"], version: wp_website["version"], server_id: server.id)
        website.save!
      else
        website = Website.where(:name => wp_website["name"], :server_id => server.id).first
        website.version = wp_website["version"]
      end

      wp_website["plugins"].each do |plugin|
        unless Plugin.exists?(:name => plugin["name"], :website_id => website.id)
          plugin = Plugin.new(name: plugin["name"], version: plugin["version"], updates: plugin["update"], status: plugin["status"], website_id: website.id)
        else
          plugin = Plugin.where(:name => plugin["name"], :website_id => website.id).first
          plugin.version = plugin["version"]
          plugin.updates  = plugin["update"]
          plugin.status  = plugin["status"]
        end

        plugin.save!
      end
    end

    redirect_to :action => "index"
  end

end
