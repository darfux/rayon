module SearchHelper
	def get_check_state(key)
		if key == :user_name
			return true
		end
		return false
	end
end
