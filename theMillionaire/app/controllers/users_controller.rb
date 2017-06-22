class UsersController < ApplicationController

  skip_before_filter :find_login_user, :only => [:new, :create]
  before_action :set_user, :only=> [:show, :edit, :update, :destroy]
  skip_before_filter :login_required, :only=>[:new,:create]
  before_filter :admin_required, :only=>[:index,:destroy]
  before_filter :retrieve_user, :only => [:show, :edit, :udpate]


  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    user_id=params[:id]
    name=params[:name]
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)


      if @user.save
        session[:user_id] = @user.id
        flash[:notice] = "ログインに成功しました"
        redirect_to setup_path #ユーザーのメニュー画面へいく
      else
        format.html { render :new }
      end

  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
    if @user.update_attributes(params[:user])
redirect_to @user, :notice => 'User was successfully updated.'
    else
      render "edit"
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:user_id, :name, :password)
    end
    def retrieve_user
    unless @login_user.adm? or @login_user.id == @user.id
        redirect_to user_path(@login_user)
      end
    end
