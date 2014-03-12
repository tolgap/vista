class WebsitesController < ApplicationController
  before_filter :load_server

  # GET /websites
  # GET /websites.json
  def index
    @websites = Website.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @websites.to_json(:include => :plugins) }
    end
  end

  # GET /websites/1
  # GET /websites/1.json
  def show
    @website = Website.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @website.to_json(:include => :plugins) }
    end
  end

  # GET /websites/new
  # GET /websites/new.json
  def new
    @website = Website.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @website }
    end
  end

  # GET /websites/1/edit
  def edit
    @website = Website.find(params[:id])
  end

  # POST /websites/save
  # POST /websites/save.json
  def save
    Website.exists?(name: params[:website][:name]) ? update : create
  end

  # POST /websites/create_or_update
  # POST /websites/create_or_update.json
  def create_or_update
    @server = Server.find_or_create_by_name(params.delete(:server))
    @website = @server.websites.find_or_create_by_name(params[:website][:name])
    @website.update_attributes(params[:website].except(:plugins))

    respond_to do |format|
      if @website.save!
        process_plugins

        format.html { redirect_to [@server, Website], notice: 'Website was successfully created.' }
        format.json { head :no_Content, status: :created }
      else
        format.html { render action: "new" }
        format.json { render json: @website.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /websites
  # POST /websites.json
  def create
    @server  = Server.find_or_create_by_name(params[:server_id])
    @website = @server.websites.new(params[:website])

    respond_to do |format|
      if @website.save!
        process_plugins

        format.html { redirect_to [@server, Website], notice: 'Website was successfully created.' }
        format.json { head :no_Content, status: :created }
      else
        format.html { render action: "new" }
        format.json { render json: @website.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /websites/1
  # PUT /websites/1.json
  def update
    @website = Website.find_by_name(params[:website][:name])

    respond_to do |format|
      if @website.update_attributes!(params[:website])
        process_plugins

        format.html { redirect_to [@server, @website], notice: 'Website was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @website.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /websites/1
  # DELETE /websites/1.json
  def destroy
    @website = Website.find(params[:id])
    @website.destroy

    respond_to do |format|
      format.html { redirect_to server_websites_url(@server) }
      format.json { head :no_content }
    end
  end

private

  def process_plugins
    params[:website][:plugins].each do |p_param|
      plugin = @website.plugins.find_or_create_by_name(p_param[:name])
      p_param.each do |attribute, value|
        plugin.send("#{attribute.to_s}=", value)
      end
      plugin.save
    end
  end
end
