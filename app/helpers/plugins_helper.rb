module PluginsHelper

	def create_list_item(plugin)
		html = '<li class="' + plugin.status + ' plugin">'

		if (plugin.updates === "available")
			span = ' <span class="update label label-important">Has update</span>'
		else
			span = ' <span class="update label label-success">Up to date</span>'
		end

		span += ' <span class="update label label-warning">Inactive</span>' if (plugin.status === "inactive")

		version = ' <span class="version">(' + plugin.version + ')</span>'

		html += link_to plugin.name.titleize, plugin_path(plugin)
		html += version + span + '</li>'
	end

end