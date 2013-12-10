module PapersHelper
  def get_own_type_select
    selects = []
    OwnType.all.each {|source| selects<<[source.name, source.id.to_i]}
    selects
  end

  def get_own_type(paper, user)
    UserOwnType.find(
        PaperUser.where(user_id: user.id, paper_id: paper.id
            ).first.user_own_type_id
                ).name
  end

  def get_own_id(paper, user)
    return nil if paper.nil? || user.nil?
    paperUser = PaperUser.where(user_id: user.id, paper_id: paper.id
            ).first
    return nil if paperUser.nil?
    paperUser.user_own_type_id
  end
end
