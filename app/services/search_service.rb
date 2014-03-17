class SearchService
  def initialize(params)
    @params = params
  end

  def search
    if @params[:type].blank?
      raise ArgumentError.new "No model to search"
    end

    klass = @params[:type].classify.constantize
    s = klass.__elasticsearch__.search query_string
    s.page(@params[:page]).results
  end

  def query_string
    "*#{@params[:q]}*"
  end
end