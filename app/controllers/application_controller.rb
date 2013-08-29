class ApplicationController < ActionController::Base

  def search
    if (params[:query])
      @search_query = params[:query]
      @sort_type    = params[:sort]
      q             = @search_query.split(" ")

      if (q.include?('@plugin'))
        q.delete('@plugin')
        @results = order_using(Plugin.where("name LIKE ?", q), :plugin, @sort_type).all
      elsif (q.include?('@website'))
        q.delete('@website')
        @results = order_using(Website.where("name LIKE ? OR blog_name LIKE ?", q, q), :website, @sort_type).all
      elsif (q.include?('@core'))
        q.delete('@core')
        @results = order_using(Website.where("version = ?", q), :website, @sort_type).all
      else
        websites = order_using(Website.where("name LIKE ? OR blog_name LIKE ? OR version = ?", q, q, q), :website, @sort_type).all
        plugins  = order_using(Plugin.where("name LIKE ? OR version LIKE ?", q, q), :plugin, @sort_type).all
        @results = (websites + plugins).flatten
      end
    end

    respond_to do |format|
      format.html { render :template => "shared/search" }
      format.js { render :template => "shared/results" }
    end
  end

  def order_using (objects, type, sort = "name")
    case sort
    when "name"
      objects.order(:name)
    when "version"
      objects.order(:version)
    when "update_available"
    end
  end

protected

  def load_server
    @server = Server.find(params[:server_id])
  end

  def load_website
    @website = Website.find(params[:website_id])
  end

end
