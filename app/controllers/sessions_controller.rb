class SessionsController < ApplicationController
  
  def new
  end 
  
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user&.authenticate(params[:session][:password])
      if @user.activated?
        flash[:success] = "ログインしました。"
        log_in @user
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        redirect_back_or @user
      else 
        message = "アカウントが有効化されてません。"
        message += "メールに送られた有効化URLをご確認ください。"
        flash[:warning] = message
        redirect_to root_url
      end 
    else
      flash.now[:danger] = "メールアドレスとパスワードの組み合わせが正しくありません。"
      render 'new'
    end 
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end 
end