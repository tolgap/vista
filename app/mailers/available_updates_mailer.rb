class AvailableUpdatesMailer < ActionMailer::Base
  default from: Settings.default_mail_from

  def updates_mail(type, data)
    @type = type.to_s.capitalize
    @data = data

    mail(to: Settings.default_mail_to,
      subject: "#{@data.size} Available updates for #{@type} websites",
      template_path: 'mailers',
      template_name: 'available_updates')
  end
end