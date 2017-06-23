class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #ApplicationControllerは、他のコントローラでも使えるメソッドを定義
  #する場所

   before_action :find_login_user #アクション前にログインチェック

   def find_login_user #登録済みのユーザーか判断し、ログインする
        @login_user = User.find_by_id(session[:user_id])
        unless @login_user
             redirect_to login_url and return false
        end
end

  private
  def admin_required #管理者でなければセットアップ画面へ
    unless @login_user.adm?
      redirect_to setup_path(@login_user)
    end
end
end
