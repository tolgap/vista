class ApplicationController < ActionController::Base

protected

  def load_server
    @server = Server.find(params[:server_id])
  end

  def load_website
    @website = Website.find(params[:website_id])
  end

end
