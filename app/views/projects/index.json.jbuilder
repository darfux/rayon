json.array!(@projects) do |project|
  json.extract! project, :name, :description, :user_id, :year, :source
  json.url project_url(project, format: :json)
end
