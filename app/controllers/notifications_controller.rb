class NotificationsController < ApplicationController
  before_action :logged_in_user, only: [:new,:show,:create,:edit,:update,:destroy]
  before_action :correct_user, only: [:destroy]
  
  def show
    @notice = current_user.notifications.find_by(id: params[:id])
  end
  
  def index
    @notices = current_user.notifications.all
  end 

  def new
    @notice = current_user.notifications.build
    @subject = params[:subject]
    @homework_test = params[:homework_test]

  end
  
  def create
    @notice = current_user.notifications.build(notice_params)
    if @notice.save
      flash[:success] = "登録しました"
      redirect_to notifications_url
    else 
      render 'notifications/new'
    end 
  end 
  
  def edit
    @notice = current_user.notifications.find_by(id: params[:id])
  end 
  
  def update
    @notice = Notification.find_by(id: params[:id])
    if @notice.update(notice_params)
      flash[:success] = "更新しました"
      redirect_to notifications_url
    else
      render 'notifications/edit'
    end 
  end 
  
  def destroy
    @notice.destroy
    flash[:success] = "削除しました"
    redirect_to notifications_url || root_url #requireをやめた
  end 
  
  private
    def notice_params
      params.require(:notification).permit(:subject,:start_time,:homework_test,:over)
    end 
    
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end 
    end
    
    def correct_user
      @notice = current_user.notifications.find_by(id: params[:id])
      redirect_to root_url if @notice.nil?
    end 
end
