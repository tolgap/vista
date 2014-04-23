namespace :mail do
  namespace :available_updates do

    task wordpress: :environment do
      service = UpdateService.new(:wordpress)
      @data = service.available_updates
      unless @data.blank?
        AvailableUpdatesMailer.updates_mail(:wordpress, @data).deliver
      end
    end

    task drupal: :environment do
      service = UpdateService.new(:drupal)
      @data = service.available_updates
      unless @data.blank?
        AvailableUpdatesMailer.updates_mail(:drupal, @data).deliver
      end
    end

  end
end