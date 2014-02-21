class SearchResult
end
class Searcher
  def self.search(params)
    user_result = User.search{ fulltext params[:content]}
    project_result = Project.search { fulltext params[:content] }
    achievement_result = Achievement.search{ fulltext params[:content]}
    paper_result = Paper.search{ fulltext params[:content]}
    raise (project_result.results<<user_result.results<<achievement_result.results<<paper_result.results).to_s
  end
end