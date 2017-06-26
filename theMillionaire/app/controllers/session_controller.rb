class SessionController < ApplicationController
  skip_before_filter :find_login_user, :only => [:new, :create]

  def new
  end

  def create
     @user_id = params[:user_id]
    @password = params[:password]
    @user= User.authenticate @user_id,@password



    if @user
      session[:user_id] = @user.id
      session[:user_name]=@user.name
      flash[:notice] = "ログインに成功しました"
      if @user.adm
        redirect_to users_path
      else
        redirect_to chat_path #ユーザーのメニュー画面へいく
      end
    else
      @error = "ログインに失敗しました"
        render :action => :new
    end
  end

   def destroy
         reset_session
         redirect_to login_url
     end

end
