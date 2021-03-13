require 'rails_helper'

RSpec.describe 'サインアップテスト',type: :system do
    include TestHelper

    before do
        ActionMailer::Base.deliveries.clear
    end

    subject { page }

    context 'nameが無効の場合' do
        scenario "無効" do
            visit signup_path
            is_expected.to have_content "Sign up"
            fill_in "user_name",with: ""
            fill_in "user_email",with: "user@yahoo.co.jp"
            fill_in "user_password",with: "password"
            fill_in "user_password_confirmation",with: "password"
            find('input[name="commit"]').click
            is_expected.to have_content "Sign up"
            is_expected.to have_content "エラー"
        end
    end

    context 'emailが無効の場合' do
        scenario "無効" do
            visit signup_path
            is_expected.to have_content "Sign up"
            fill_in "user_name",with: "user"
            fill_in "user_email",with: "invalid"
            fill_in "user_password",with: "password"
            fill_in "user_password_confirmation",with: "password"
            find('input[name="commit"]').click
            is_expected.to have_content "Sign up"
        end
    end

    context 'passwordとpassword_confirmationの組み合わせが無効の場合' do
        scenario "無効" do
            visit signup_path
            is_expected.to have_content "Sign up"
            fill_in "user_name",with: "user"
            fill_in "user_email",with: "user@yahoo.co.jp"
            fill_in "user_password",with: "password"
            fill_in "user_password_confirmation",with: "foobar"
            find('input[name="commit"]').click
            is_expected.to have_content "Sign up"
            is_expected.to have_content "エラー"
        end
    end

    context '有効な情報を登録した場合' do
        scenario "有効" do
            visit signup_path
            is_expected.to have_content "Sign up"
            fill_in "user_name",with: "user"
            fill_in "user_email",with: "user@yahoo.co.jp"
            fill_in "user_password",with: "password"
            fill_in "user_password_confirmation",with: "password"
            find('input[name="commit"]').click
            is_expected.to have_content "アカウント有効化メールをご登録頂いたメール宛に送信しました。ご確認下さい。"
            is_expected.to have_content "最高の時間管理を"
            expect(ActionMailer::Base.deliveries.size).to eq 1
            #これ以上は、user=assigns(:user)の代わりがわからないのでかけない
            #controller.instance_variable_get('@user')は失敗した
        end
    end

    context "有効化メール送信後" do
        scenario "有効化してない状態でログイン" do
            post users_path,params: { user: { name: "user",email: "user@example.com",password: "foobar",password_confirmation: "foobar" } }
            user = controller.instance_variable_get('@user')
            expect(ActionMailer::Base.deliveries.size).to eq 1
            log_in_as(user)
            expect(response).to redirect_to user
            follow_redirect!
            expect(page).to have_content "アカウントが有効化されてません。メールに送られた有効化URLをご確認ください。"
            expect(response).to redirect_to root_url
        end

        scenario "有効化トークンが不正の場合" do
            post users_path,params: { user: { name: "user",email: "user@example.com",password: "foobar",password_confirmation: "foobar" } }
            user = controller.instance_variable_get('@user')
            expect(ActionMailer::Base.deliveries.size).to eq 1
            visit edit_account_activation_path("invalid token",email: user.email)
            expect(page).to have_content "アカウント有効化失敗"
            expect(page).to have_selector 'div.alert-danger'
        end

        scenario "トークンは正しいがメールアドレスが無効な場合" do
            post users_path,params: { user: { name: "user",email: "user@example.com",password: "foobar",password_confirmation: "foobar" } }
            user = controller.instance_variable_get('@user')
            expect(ActionMailer::Base.deliveries.size).to eq 1
            visit edit_account_activation_path(user.activation_token,email: 'wrong')
            expect(page).to have_content "アカウント有効化失敗"
            expect(page).to have_selector 'div.alert-danger'
        end

        scenario "トークンもメールアドレスも正しい場合" do
            post users_path,params: { user: { name: "user",email: "user@example.com",password: "foobar",password_confirmation: "foobar" } }
            user = controller.instance_variable_get('@user')
            expect(ActionMailer::Base.deliveries.size).to eq 1
            visit edit_account_activation_path(user.activation_token,email: user.email)
            expect(page).to have_content "アカウント有効化に成功しました!"
            expect(page).to have_selector 'div.alert-success'
        end

    end




end