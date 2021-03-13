require 'rails_helper'

RSpec.describe StudytimesController, type: :controller do
    before do
        @user = create(:user)
        @other_user = create(:other_user)
        @studytime = @user.studytimes.create!(day: Date.today,time: 60,ctime: 30)
    end

    describe 'Studytimeコントローラー' do
        include SessionsHelper
        
        subject { response }
        
        it 'ログインしないとnewページに行けない' do
            get :new
            is_expected.to redirect_to login_url
        end

        it 'ログインしないとcreateできない' do
            post :create,params: { id: @user.id,studytime: { day: Date.yesterday,time: 60,ctime: 30 }}
            is_expected.to redirect_to login_url
        end

        it 'ログインしないとeditページに行けない' do
            get :edit,params: { id: @studytime.id }
            is_expected.to redirect_to login_url
        end

        it 'ログインしないとupdateできない' do
            patch :update,params: { id: @studytime.id, studytime: { time: 70 } }
            is_expected.to redirect_to login_url
        end

        it 'ログインしないとdestroyできない' do
            delete :destroy,params: { id: @studytime.id }
            is_expected.to redirect_to login_url
        end

        it 'カレントユーザーでないとdestroyできない' do
            log_in(@other_user)
            delete :destroy,params: { id: @studytime.id }
            is_expected.to redirect_to root_url
        end

    end

end
