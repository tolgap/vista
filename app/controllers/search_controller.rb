class SearchController < ApplicationController

  def index
  end

  def search
    @results = SearchService.new(params).search

    respond_to do |format|
      format.html
      format.json { render json: @results }
      format.js
    end
  end
end