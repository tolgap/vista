class Server < ActiveRecord::Base
  attr_accessible :name, :websites_attributes
  has_many :websites
  has_many :plugins, through: :websites

  accepts_nested_attributes_for :websites

  def to_param
    self.name
  end

  def self.find(input)
    if input.is_integer?
      super
    else
      self.find_by_name(input)
    end
  end
end

class String
  def is_integer?
    !!(self =~ /\A[0-9]+\Z/)
  end
end