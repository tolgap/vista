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

end
