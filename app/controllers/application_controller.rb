class ApplicationController < ActionController::Base

  def search
    if (params[:query])
      @search_query = params[:query]
      q = @search_query.split(" ")

      if (q.include?('@plugin'))
        q.delete('@plugin')
        @results = Plugin.where("name LIKE ?", q).order(:name).all
      elsif (q.include?('@website'))
        q.delete('@website')
        @results = Website.where("name LIKE ? OR blog_name LIKE ?", q, q).order(:name).all
      elsif (q.include?('@core'))
        q.delete('@core')
        @results = Website.where("version = ?", q).order(:name).all
      else
        websites =  Website.where("name LIKE ? OR blog_name LIKE ? OR version = ?", q, q, q).order(:name).all,
        plugins  = Plugin.where("name LIKE ? OR version LIKE ?", q, q).order(:name).all
        @results = (websites + plugins).flatten
      end
    end

    respond_to do |format|
      format.html { render :template => "servers/list_updates"}
      format.js { render :template => "shared/results" }
    end
  end
  
end
