require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    before do
        @user = create(:user)
        @other_user = create(:other_user)
    end

    describe 'users_controllerテスト' do
        include SessionsHelper

        it 'newを取得' do
            get :new
            expect(response).to have_http_status(:success)
        end

        it 'ログインしないとindexにアクセスできない' do
            get :index
            expect(response).to redirect_to login_url
        end

        it 'ログインなしでuser更新はできない' do
            patch :update, params: { id: @user.id,user: { name: "gogo",email: @user.email }}
            expect(response).to have_http_status "302"        
        end

        it '違うユーザーのログインではeditページには行けない' do
            log_in(@other_user)
            get :edit,params: { id: @user.id }
            expect(response).to redirect_to root_url
        end

        it '違うユーザーのログインではuserを更新できない' do
            log_in(@other_user)
            patch :update,params: { id: @user.id, user: { name: "gogo"}}
            expect(response).to redirect_to root_url
        end

        it 'ログインしてないとユーザー消去できない' do
            expect{ delete :destroy,params: { id: @user.id } }.to change{ User.count }.by(0)
            expect(response).to redirect_to login_url
        end

        it 'アドミンユーザーでないとアドミンユーザーは消去できない' do
            log_in(@other_user)
            expect{ delete :destroy,params: { id: @user.id } }.to change{ User.count }.by(0)
            expect(response).to redirect_to root_url
        end
    end
end
