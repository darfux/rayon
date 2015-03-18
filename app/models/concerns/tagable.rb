module Tagable
  extend ActiveSupport::Concern
  def relate_tags(user)
    tag = []
    user.research_directions.each do |rd|
      rd.get_segmentation.each do |rdseg|
        if name.match(rdseg)
          tag << rd.name
          break
        end
      end
    end
    tag
  end
end