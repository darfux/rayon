# OriginalDismax = Sunspot::Query::Dismax

# class PatchedDismax < OriginalDismax

#   def to_params
#     params = super
#     params[:defType] = 'edismax'
#     params
#   end

#   def to_subquery
#     query = super
#     query = query.sub '{!dismax', '{!edismax'
#     query
#   end

# end

# Sunspot::Query.send :remove_const, :Dismax
# Sunspot::Query::Dismax = PatchedDismax

class SearchController < ApplicationController
  # before_action :inital_search_type, only: [:index, :search]
  cattr_accessor :SEARCH_TYPE
  @@SEARCH_TYPE = {
        user_name: {label: '专家', record: User, attribute: :name, method: :text_search},
        project_name: {label: '项目', record: Project, attribute: :name,  method: :text_search}
      }
  def project
  end

  def index
    respond_to do |format| 
      format.html
      format.js
    end
  end
  def index_test
    render layout: false
  end
  def achievement
  end

  def paper
  end

  def expert
  end

  def search
    search = Project.search { fulltext params[:content] }
    @results = search.results
    # search = @@SEARCH_TYPE[params[:search_type].to_sym]
    # search_content = params[:search][:search_content]
    # @results = self.send(search[:method], search[:record], search[:attribute], search_content)
    # respond_to do |format| 

    #   format.js
    # end
    render 'result'
  end

  private
    def inital_search_type
    end

    def text_search(record, attribute, query)
      if query.strip.empty?#prevent generating search result
        return nil
      end
      # results = []
      # query.split(' ').each do |elm|#split the words for searching
      #   p elm
      #   search = record.search do
      #     fulltext elm do
      #       fields(attribute)
      #     end
      #   end
      #   results.push search.results
      # end
      # result_set = results.pop.to_set
      # results.each do |ar|
      #   result_set = result_set & ar.to_set
      # end
      # result_set

      # ===For single match searching
      search = record.search do
        fulltext query do
          fields(attribute)
        end
      end
      search.results
      # =============================

    end
end
