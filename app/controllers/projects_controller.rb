class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :update, :destroy, :edit]
  before_action :set_user, only: [:show, :create, :edit, :manage_list, :manage_tag, :update]
  before_action :set_projects, only: [:manage_list, :manage_tag]
  before_action :set_participation, only: [:update]
  before_action :set_meta

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    # @back_link = @@manage_page if flash[:burst_back]
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /projects/new
  def new
    @project = Project.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /projects/1/edit
  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    respond_to do |format|
      begin
        Project.transaction do
          @project.save!
          @project.project_users.create!({user_id: @user.id,
            participation_type_id: params[:participation_type_id]})
        end
        format.html {render action: 'show'}
        format.js {render action: 'show'}
      rescue Exception => e
        format.html { render action: 'edit' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
        format.js {render action: 'show'}
        format.js {render text: "alert('#{@project.errors}')"}
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      begin
        Project.transaction do
          @project.update(project_params)
          par_type = params[:participation_type_id]
          @par.update!({participation_type_id: par_type}) if par_type
        end
        format.html { redirect_to @project, flash: { burst_back:true } }
        format.json { head :no_content }
        format.js {render action: 'show'}
      rescue Exception => e
        format.html { render action: 'edit' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to request.referer }
      format.json { head :no_content }
    end
  end

  def manage_list
    # @@manage_page = project_manage_list_path
    render "shared/manage_list"
    # respond_to do |format|
    #   format.html
    #   format.js
    # end
  end  

  def manage_tag
    # @@manage_page = project_manage_tag_path
    render "shared/manage_tag"
  end

  private
    # @@manage_page = ProjectsController.instance_method(:project_manage_list_path)
    # Use callbacks to share common setup or constraints between actions.
    def set_meta
      @header_meta = "项目管理"
      @obj_name = get_obj_name
      @obj_list_metas = [
        {title: "项目名称", attri: :name},
        {title: "简介", attri: :description, 
          callback: {handler: :get_brief_text}
        },
        {title: "开始/结束时间", attri: :during},
        {title: "状态", attri: :state},
        {title: "来源", attri: :source},
        {title: "类型", attri: :participation, params: @user}
      ]
      @obj_tag_metas = [
        :description,
        [
          {title: "来源", attri: :source},
          {title: "状态", attri: :state},
          {title: "类型", attri: :participation, params: @user}
        ]
      ]
    end

    def set_user
      @user = User.find(session[:user_id])
    end

    def set_projects
      @projects = @user.projects.to_a
      @objects = @projects
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      # p params
      @project = Project.find_by_id(params[:id])
    end
    def set_participation
      @par = ProjectUser.find_by(project_id: params[:id], user_id: session[:user_id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :description, :start, :end, 
        :source_id, :project_type_id, :project_state_id)
    end
end
