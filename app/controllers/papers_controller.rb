class PapersController < ApplicationController
  before_action :set_paper, only: [:show, :update, :destroy, :edit]
  before_action :set_user, only: [:show, :create, :edit, :manage_list, :manage_tag, :update]
  before_action :set_papers, only: [:manage_list, :manage_tag]
  before_action :set_participation, only: [:update]
  before_action :set_meta
  # GET /papers
  # GET /papers.json
  def index
    @papers = Paper.all
  end

  # GET /papers/1
  # GET /papers/1.json
  def show
    @back_link = @@manage_page if flash[:burst_back]
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /papers/new
  def new
    @paper = Paper.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /papers/1/edit
  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /papers
  # POST /papers.json
  def create
    @paper = Paper.new(paper_params)
    respond_to do |format|
      begin
        Paper.transaction do
          @paper.save!
          @paper.paper_users.create!({user_id: @user.id,
            user_own_type_id: params[:user_own_type_id]})
        end
        @back_link = @@manage_page
        format.html {render action: 'show'}
        format.js {render action: 'show'}
      rescue Exception => e
        format.html { render action: 'edit' }
        format.json { render json: @paper.errors, status: :unprocessable_entity }
        format.js {render action: 'show'}
        format.js {render text: "alert('#{@paper.errors}')"}
      end
    end
  end

  # PATCH/PUT /papers/1
  # PATCH/PUT /papers/1.json
  def update
    respond_to do |format|
      begin
        Paper.transaction do
          @paper.update(paper_params)
          own_type = params[:own_type_id]
          @own.update!({user_own_type_id: own_type}) if own_type
        end
        format.html { redirect_to @paper, flash: { burst_back:true } }
        format.json { head :no_content }
        format.js {render action: 'show'}
      rescue Exception => e
        format.html { render action: 'edit' }
        format.json { render json: @paper.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /papers/1
  # DELETE /papers/1.json
  def destroy
    @paper.destroy
    respond_to do |format|
      format.html { redirect_to request.referer }
      format.json { head :no_content }
    end
  end

  def manage_list
    @@manage_page = paper_manage_list_path
    render "shared/manage_list"
  end  

  def manage_tag
    @@manage_page = paper_manage_tag_path
    respond_to do |format|
      format.html
      format.js
    end
  end

  private
    @@manage_page = PapersController.instance_method(:paper_manage_list_path)
    # Use callbacks to share common setup or constraints between actions.

    def set_meta
      @header_meta = "文献管理"
      @obj_name = get_obj_name
      @obj_metas = [
        {title: "论文标题", attri: :title},
        {title: "身份", attri: :own_type, params: @user},
        {title: "发表于", attri: :publish, handler: :get_brief_text}
      ]
    end

    def set_user
      @user = User.find(session[:user_id])
    end

    def set_papers
      @papers = @user.papers.to_a
      @objects = @papers
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_paper
      # p params
      @paper = Paper.find_by_id(params[:id])
    end
    def 
      set_participation
      @own = PaperUser.find_by(paper_id: params[:id], user_id: session[:user_id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def paper_params
      params.require(:paper).permit(:title, :publish)
    end
end
