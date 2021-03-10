class StudytimesController < ApplicationController
  before_action :logged_in_user,only: [:new,:show,:create,:edit,:update,:destroy]
  before_action :correct_user,only: [:destroy]

  def show
    @studytimes = current_user.studytimes.where(day: Date.today.ago(31.day).strftime("%Y-%m-%d")..Date.today.strftime("%Y-%m-%d"))
    @studyctime = current_user.studytimes.all.sum(:ctime) #Studytime~からcurrent_user~に変更
    @studynotime = current_user.studytimes.all.sum(:time)-current_user.studytimes.all.sum(:ctime) #変更
  end
  
  def index
    @studytimes = current_user.studytimes.paginate(page: params[:page],per_page: 15) 
  end 

  def new
    @studytime = current_user.studytimes.build
  end
  
  def create 
    @studytime = current_user.studytimes.build(studytime_params)
    if @studytime.save
      flash[:success] = "登録しました"
      redirect_to studytimes_show_url
    else 
      render 'studytimes/new'
    end 
  end 
  
  def edit
    @studytime = Studytime.find_by(id: params[:id])
  end 
  
  def update
    @studytime = Studytime.find_by(id: params[:id])
    if @studytime.update(studytime_params)
      flash[:success] = "更新しました"
      redirect_to studytimes_show_url
    else
      render 'studytimes/edit'
    end 
  end 
  
  def destroy
    @studytime.destroy
    flash[:success] = "削除しました"
    redirect_to request.referrer || root_url
  end 
  
  private
    def studytime_params
      params.require(:studytime).permit(:day,:time,:ctime)
    end 
    
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end 
    end 
    
    def correct_user
      @studytime = current_user.studytimes.find_by(id: params[:id])
      redirect_to root_url if @studytime.nil?
    end 
    

end
