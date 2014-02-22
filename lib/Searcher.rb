class SearchResult
  attr_reader :results, :num
  def initialize(user, project, achiev, paper)
    @results = (user+project+achiev+paper).flatten
    @num = {
      expert: user.size,
      project: project.size,
      achievement: achiev.size,
      paper: paper.size,
      total: @results.size
    }
  end
  def each
    @results.each do |result|
      yield result
    end
  end
end
class Searcher
  def self.search(params)
    user = User.search{ fulltext params[:content]}
    project= Project.search { fulltext params[:content] }
    achievement = Achievement.search{ fulltext params[:content]}
    paper = Paper.search{ fulltext params[:content]}
    SearchResult.new(user.results, project.results, achievement.results, paper.results) 
  end
end