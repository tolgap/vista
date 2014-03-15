class Plugin < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  attr_accessible :name, :status, :has_update, :version
  belongs_to :website

  index_name "#{Rails.application.class.parent_name.downcase}_#{Rails.env}_plugins"

  mapping do
    indexes :name, analyzer: 'snowball'
    indexes :version, analyzer: 'snowball'
    indexes :has_update, type: :boolean
    indexes :status
  end

  def wp_info
    require 'php_serialize'

    uri = URI.parse("http://api.wordpress.org/plugins/info/1.0/" + self.name)
    res = Net::HTTP.get(uri)

    result = PHP.unserialize(res)
    if result.nil?
      false
    else
      result
    end
  end
end
