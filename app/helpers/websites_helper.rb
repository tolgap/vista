module WebsitesHelper

  def has_update(website)
    update = false

    website.plugins.each do |plugin|
      if (plugin.status === "active" and plugin.updates === "available")
        update = true
        break
      end
    end

    update
  end

  def create_search_item(website)
    html = '<li class="website-item">'
    version = ' <span class="badge badge-info">' + website.version + '</span>'
    html += link_to website.blog_name, [website.server, website]
    location = " on server <strong>" + website.server.name + "</strong> at " + website.name
    html += version + location + '</li>'
  end

  def row_classes_for(website)
    classes = []
    classes << "has-errors" if website.has_errors?
    classes.join(' ')
  end

  def plugins_row_class_version(plugin)
    span_type = plugin.has_update? ? "warning" : "info"
    row_badge(plugin.version, span_type)
  end

  def websites_row_class_version(website)
    span_type = website.has_update_by_type? ? "warning" : "info"
    row_badge(website.version, span_type)
  end

  def row_badge(content, type)
    content_tag(:span, content, class: "badge badge-#{type}")
  end

end
