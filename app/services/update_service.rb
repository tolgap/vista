class UpdateService

  def initialize(type)
    @type = type
  end

  def available_updates
    sites = []
    Server.where(has_mail: true).map do |server|
      sites += server.websites.where(has_update: true,
        cms_type: @type, has_errors: false)
    end
    sites
  end

end