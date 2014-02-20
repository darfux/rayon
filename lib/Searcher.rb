class Searcher
  def self.search(params)
    Project.search { fulltext params[:content] }
  end
end