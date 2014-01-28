module ManageHelper
	def get_config
		File.open("config/app/manage.yml", 'r'){ |f| 
			result = YAML.load(f)
		}
	end
end
