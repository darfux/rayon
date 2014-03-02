module SearchHelper
  def css_name(result)
    return 'expert' if result.class == User
    return result.class.to_s.downcase
  end
	def get_check_state(key)
		if key == :user_name
			return true
		end
		return false
	end
end