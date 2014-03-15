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

  def row_class_version(versionable)
    span_type = versionable.has_update? ? "warning" : "info"
    content_tag(:span, versionable.version, class: "badge badge-#{span_type}")
  end

end
