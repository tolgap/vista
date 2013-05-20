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

end
