class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_filter :authorize, only: [:new, :create]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    respond_to do |format|
      session[:user_id] = @user.id
      format.html
      format.js
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.uid = (User.try(:last).try(:id) || 0)+ 100000
    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to welcome_path}
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @saved = @user.update(user_params)
    respond_to do |format|
      if @saved
        format.html { redirect_to @user }
        format.js
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.js 
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation, :title_id, :unit_id, :email, :tel, :introduction)
    end
end
