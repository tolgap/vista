class ServersController < ApplicationController
  before_filter :check_wp_version
  add_breadcrumb "Home", :root_path

  # GET /servers
  # GET /servers.json
  def index
    @servers = Server.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @servers.to_json(:include => { :websites => {:include => :plugins } }) }
    end
  end

  # GET /servers/1
  # GET /servers/1.json
  def show
    @server = Server.find(params[:id])
    add_breadcrumb @server.name, [@server]

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @server.to_json(:include => { :websites => {:include => :plugins } }) }
    end
  end

  # GET /servers/1/visualize
  # GET /servers/1/visualize.json
  def visualize
    @server = Server.find(params[:id])
    add_breadcrumb @server.name, [@server]
    add_breadcrumb "visualizing", [:visualize, @server]

    wp_service = VisualizationService.new(@server, :wordpress)
    dp_service = VisualizationService.new(@server, :drupal)
    @wordpress_data = wp_service.gather
    @drupal_data    = dp_service.gather

    respond_to do |format|
      format.html
      format.json { render json: { server: @server,
        wp_data: @wordpress_data, dp_data: @drupal_data} }
    end
  end

  # GET /servers/new
  # GET /servers/new.json
  def new
    @server = Server.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @server }
    end
  end

  # GET /servers/1/edit
  def edit
    @server = Server.find(params[:id])
  end

  # POST /servers
  # POST /servers.json
  def create
    @server = Server.new(params[:server])

    respond_to do |format|
      if @server.save
        format.html { redirect_to @server, notice: 'Server was successfully created.' }
        format.json { render json: @server, status: :created, location: @server }
      else
        format.html { render action: "new" }
        format.json { render json: @server.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /servers/1
  # PUT /servers/1.json
  def update
    @server = Server.find(params[:id])

    respond_to do |format|
      if @server.update_attributes(params[:server])
        format.html { redirect_to @server, notice: 'Server was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @server.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /servers/1
  # DELETE /servers/1.json
  def destroy
    @server = Server.find(params[:id])
    @server.destroy

    respond_to do |format|
      format.html { redirect_to servers_url }
      format.json { head :no_content }
    end
  end

  # GET /updates
  # GET /updates.json
  def list_updates
    @updates = Server.all

    @updates.each do |server|
      server.websites.delete_if do |website|
        puts website.has_update
        true unless website.has_update
      end
    end

    respond_to do |format|
      format.html
      format.json { render :json => @updates.to_json(:include => { :websites => {:include => :plugins } }) }
    end
  end

  def check_wp_version
    @wp_version = Website.check_latest_wp_version
  end
end
