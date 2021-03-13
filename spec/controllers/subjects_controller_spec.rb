require 'rails_helper'

RSpec.describe SubjectsController, type: :controller do
    before do
        @user = create(:user)
        @other_user = create(:other_user)
        @subject = @user.subjects.create!(name: "math",day_of_week: "Monday",th_period: 1,definitely: true)
    end

    describe 'Subjectコントローラー' do
        include SessionsHelper
        
        subject { response }
        
        it 'ログインしないとnewページに行けない' do
            get :new
            is_expected.to redirect_to login_url
        end

        it 'ログインしないとcreateできない' do
            post :create,params: { id: @user.id,subject: { name: "math",day_of_week: "Monday",th_period: 2,definitely: true}}
            is_expected.to redirect_to login_url
        end

        it 'ログインしないとeditページに行けない' do
            get :edit,params: { id: @subject.id }
            is_expected.to redirect_to login_url
        end

        it 'ログインしないとupdateできない' do
            patch :update,params: { id: @subject.id, subject: {name: "english"} }
            is_expected.to redirect_to login_url
        end

        it 'ログインしないとdestroyできない' do
            delete :destroy,params: { id: @subject.id }
            is_expected.to redirect_to login_url
        end

        it 'カレントユーザーでないとdestroyできない' do
            log_in(@other_user)
            delete :destroy,params: { id: @subject.id }
            is_expected.to redirect_to root_url
        end

    end
end
