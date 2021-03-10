class SubjectsController < ApplicationController
  before_action :logged_in_user,only: [:new,:create,:edit,:update,:show,:destroy]
  before_action :correct_user,only: [:destroy]
  
  def new
    @subject = current_user.subjects.build
  end
  
  def create
    @subject = current_user.subjects.build(subject_params)
    if @subject.save
      flash[:success] = "追加しました。"
      redirect_to subjects_show_url
    else
      render 'subjects/new'
    end 
  end 

  def edit
    @subject = Subject.find_by(id: params[:id])
  end
  
  def update
    @subject = Subject.find_by(id: params[:id])
    if @subject.update(subject_params)
      flash[:success] = "編集しました"
      redirect_to subjects_show_url
    else
      render 'subjects/edit'
    end 
  end

  def show
    @user = current_user
    @Mo = []
    @Tu = []
    @We = []
    @Th = []
    @Fr = []
    @Sa = []
    
    (1..6).each do |n|
      @item = @user.subjects.find_by(day_of_week: "Monday",th_period: n)
      if @item.nil?
        @Mo.push("")
      else
        @Mo.push(@item)
      end 
    end

    (1..6).each do |n|
      @item = @user.subjects.find_by(day_of_week: "Tuesday",th_period: n)
      if @item.nil?
        @Tu.push("")
      else
        @Tu.push(@item)
      end 
    end

    (1..6).each do |n|
      @item = @user.subjects.find_by(day_of_week: "Wednesday",th_period: n)
      if @item.nil?
        @We.push("")
      else
        @We.push(@item)
      end 
    end

    (1..6).each do |n|
      @item = @user.subjects.find_by(day_of_week: "Thursday",th_period: n)
      if @item.nil?
        @Th.push("")
      else
        @Th.push(@item)
      end 
    end

    (1..6).each do |n|
      @item = @user.subjects.find_by(day_of_week: "Friday",th_period: n)
      if @item.nil?
        @Fr.push("")
      else
        @Fr.push(@item)
      end 
    end

    (1..6).each do |n|
      @item = @user.subjects.find_by(day_of_week: "Saturday",th_period: n)
      if @item.nil?
        @Sa.push("")
      else
        @Sa.push(@item)
      end 
    end
  end 
    
  def destroy
    @subject.destroy
    flash[:success] = "消去しました"
    redirect_to subjects_show_url
  end 

  def destroy_all
    current_user.subjects.all.destroy_all
    flash[:success] = "リセットしました。"
    redirect_to subjects_show_url
  end 
  
  def index
    @user = current_user
    @Mo = []
    @Tu = []
    @We = []
    @Th = []
    @Fr = []
    @Sa = []
    
    (1..6).each do |n|
      @item = @user.subjects.find_by(day_of_week: "Monday",th_period: n)
      if @item.nil?
        @Mo.push("")
      else
        @Mo.push(@item)
      end 
    end

    (1..6).each do |n|
      @item = @user.subjects.find_by(day_of_week: "Tuesday",th_period: n)
      if @item.nil?
        @Tu.push("")
      else
        @Tu.push(@item)
      end 
    end

    (1..6).each do |n|
      @item = @user.subjects.find_by(day_of_week: "Wednesday",th_period: n)
      if @item.nil?
        @We.push("")
      else
        @We.push(@item)
      end 
    end

    (1..6).each do |n|
      @item = @user.subjects.find_by(day_of_week: "Thursday",th_period: n)
      if @item.nil?
        @Th.push("")
      else
        @Th.push(@item)
      end 
    end

    (1..6).each do |n|
      @item = @user.subjects.find_by(day_of_week: "Friday",th_period: n)
      if @item.nil?
        @Fr.push("")
      else
        @Fr.push(@item)
      end 
    end

    (1..6).each do |n|
      @item = @user.subjects.find_by(day_of_week: "Saturday",th_period: n)
      if @item.nil?
        @Sa.push("")
      else
        @Sa.push(@item)
      end 
    end
  end
  
  private
  
    def subject_params
      params.require(:subject).permit(:name,:day_of_week,:th_period,:definitely)
    end 
    
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end 
    end 
    
    def correct_user
      @subject = current_user.subjects.find_by(id: params[:id])
      redirect_to root_url if @subject.nil?
    end 
    
end
