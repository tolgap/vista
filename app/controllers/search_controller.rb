class SearchController < ApplicationController

  def search
    @search_query  = params[:query]
    @search_type   = params[:type]
    @sort_criteria = params[:sort]

    if (@search_query) #QUERY

      if (@search_type === 'plugin')
        search = Plugin.search do |query|
          fulltext @search_query do
            phrase_fields :name => 2.0
            phrase_slop   0
          end
        end
        @results = search.results
      elsif (@search_type === 'website')
        search = Website.search do |query|
          fulltext @search_query do
            phrase_fields :name => 2.0
            phrase_fields :blog_name => 1.5
            phrase_slop   0
          end
        end
        @results = search.results
      elsif (@search_type === 'core')
        search = Website.search do |query|
          fulltext @search_query do
            fields(:version)
          end
        end
        @results = search.results
      else
        search = Sunspot.search Website, Plugin do |query|
          query.keywords @search_query
        end
        @results = search.results
      end

    end #QUERY

    respond_to do |format|
      format.html { render :template => "shared/search" }
      format.js { render :template => "shared/results" }
    end

  end

end