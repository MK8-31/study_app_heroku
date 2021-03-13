require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do
    before do
        @user = create(:user)
        @other_user = create(:other_user)
        @notification = @user.notifications.create!(start_time: DateTime.now,subject: "math",homework_test: false,over: false)
    end

    describe 'notificationコントローラー' do
        include SessionsHelper
        
        subject { response }
        
        it 'ログインしないとnewページに行けない' do
            get :new
            is_expected.to redirect_to login_url
        end

        it 'ログインしないとcreateできない' do
            post :create,params: { id: @user.id,notification: { start_time: DateTime.now,subject: "math",homework_test: false,over: false }}
            is_expected.to redirect_to login_url
        end

        it 'ログインしないとeditページに行けない' do
            get :edit,params: { id: @notification.id }
            is_expected.to redirect_to login_url
        end

        it 'ログインしないとupdateできない' do
            patch :update,params: { id: @notification.id, notification: { subject: "english" } }
            is_expected.to redirect_to login_url
        end

        it 'ログインしないとdestroyできない' do
            delete :destroy,params: { id: @notification.id }
            is_expected.to redirect_to login_url
        end

        it 'カレントユーザーでないとdestroyできない' do
            log_in(@other_user)
            delete :destroy,params: { id: @notification.id }
            is_expected.to redirect_to root_url
        end

    end

end
