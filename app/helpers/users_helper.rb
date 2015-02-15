module UsersHelper
	def get_project_number(user)
		user.projects.size
	end
	def judge_saved
		if @saved
			return render('form') + "alert('success')"
		else
			return render 'form'
		end
	end
end
