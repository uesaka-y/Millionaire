class SessionController < ApplicationController
  skip_before_filter :find_login_user, :only => [:new, :create]

  def new
  end

  def create
     @user_id = params[:user_id]
    @password = params[:password]
    @user= User.authenticate @user_id,@password



    if @user#ログインしたら成功と表示
      session[:user_id] = @user.id
      flash[:notice] = "ログインに成功しました"
      if @user.adm#管理者がログインしたらユーザ一覧へ
        redirect_to users_path
      else#それ以外はセットアップ画面へ
        redirect_to setup_path #ユーザーのメニュー画面へいく
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
