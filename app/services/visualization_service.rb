class VisualizationService

  def initialize(server, type=:wordpress)
    @server = server
    @type = type
  end

  def gather
    {
      server_data: server_data,
      website_data: website_data,
      plugin_data: plugin_data,
    }
  end

  def server_data
    num_has_update = @server.websites.where(cms_type: @type,
      has_update: true).count
    num_up_to_date = @server.websites.where(cms_type: @type,
      has_update: false).count
    total = num_has_update + num_up_to_date

    { has_update: num_has_update, up_to_date: num_up_to_date, total: total }
  end

  def website_data
    versions = @server.websites.where(cms_type: @type,
      has_errors: false).pluck(:version).compact.sort

    { versions: versions.group_by{|x| x}.values }
  end

  def plugin_data
    num_has_update = @server.plugins
      .where('websites.cms_type = ? AND plugins.has_update = ?', @type, true)
    num_up_to_date = @server.plugins
      .where('websites.cms_type = ? AND plugins.has_update = ?', @type, false)
    total = num_has_update + num_up_to_date

    { has_update: num_has_update, up_to_date: num_up_to_date, total: total }
  end
end