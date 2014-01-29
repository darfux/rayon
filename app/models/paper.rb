class Paper < ActiveRecord::Base
  has_many :paper_users, :dependent => :destroy
  has_many :users, through: :paper_users

  validates_presence_of :title

  def own_type(user)
    UserOwnType.find(
        PaperUser.where(user_id: user.id, paper_id: self.id
            ).first.user_own_type_id
                ).name
  end

end
