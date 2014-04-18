module ApplicationHelper
  def humanize_boolean(bool)
    bool ? 'Yes' : 'No'
  end
end
