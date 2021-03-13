require 'rails_helper'

RSpec.describe 'パスワードリセット',type: :system do
    before do
        ActionMailer::Base.deliveries.clear
        @user = create(:user)
    end

    context "パスワード再設定準備フォームテストandパスワード再設定フォームテスト" do
        scenario "パスワード再設定準備フォームテスト(メールアドレスが無効の場合)" do
            visit new_password_reset_path
            expect(page).to have_content "パスワード再設定準備"        
            fill_in "password_reset_email",with: "invalid@yahoo.com"
            find('input[name="commit"]').click
            expect(page).to have_content "パスワード再設定準備"    
            expect(page).to have_content "メールアドレスが見つかりません。"
        end

        scenario "パスワード再設定準備フォームテスト(メールアドレスが有効の場合)" do
            visit new_password_reset_path
            expect(page).to have_content "パスワード再設定準備"
            fill_in "password_reset_email",with: @user.email
            find('input[name="commit"]').click
            expect(@user.reset_digest).to_not eq @user.reload.reset_digest
            expect(ActionMailer::Base.deliveries.size).to eq 1
            expect(page).to have_content "パスワード再設定メールを送信しました。"
        end
    end

    context "パスワード再設定フォームへのアクセステスト" do

        scenario "パスワード再設定フォーム(メールアドレスとトークンが無効)" do
            post password_resets_path, params: { password_reset: { email: @user.email } }
            user = controller.instance_variable_get('@user')
            get edit_password_reset_path('invalid', email: "")
            expect(response).to redirect_to root_url
        end

        scenario "パスワード再設定フォーム(メールアドレスが無効)" do
            post password_resets_path, params: { password_reset: { email: @user.email } }
            user = controller.instance_variable_get('@user')
            get edit_password_reset_path(user.reset_token, email: "")
            expect(response).to redirect_to root_url
        end

        scenario "パスワード再設定フォーム(トークンが無効)" do
            post password_resets_path, params: { password_reset: { email: @user.email } }
            user = controller.instance_variable_get('@user')
            get edit_password_reset_path('invalid', email: user.email)
            expect(response).to redirect_to root_url
        end
        
        scenario "パスワード再設定フォーム(メールアドレスもトークンも有効)" do
            post password_resets_path, params: { password_reset: { email: @user.email } }
            user = controller.instance_variable_get('@user')
            visit edit_password_reset_path(user.reset_token, email: user.email)
            expect(page).to have_content "パスワード再設定"
            expect(page).to have_selector('input[name="email"][type="hidden"][value="user@example.com"]',visible: false) #hiddenは感知できない？->viseble: falseで対応
        end
        
    end

    context "パスワード再設定フォーム（メールアドレスとメールアドレス確認）" do
        scenario "無効なパスワードとパスワード確認" do
            post password_resets_path, params: { password_reset: { email: @user.email } }
            user = controller.instance_variable_get('@user')
            visit edit_password_reset_path(user.reset_token, email: user.email)
            expect(page).to have_content "パスワード再設定"
            fill_in "user_password",with: "foobaz"
            fill_in "user_password_confirmation",with: "quufoo"
            find('input[name="commit"]').click
            expect(page).to have_selector 'div#error_explanation'
        end

        scenario "パスワードが空" do
            post password_resets_path, params: { password_reset: { email: @user.email } }
            user = controller.instance_variable_get('@user')
            visit edit_password_reset_path(user.reset_token, email: user.email)
            expect(page).to have_content "パスワード再設定"
            fill_in "user_password",with: ""
            fill_in "user_password_confirmation",with: ""
            find('input[name="commit"]').click
            expect(page).to have_selector 'div#error_explanation'
        end

        scenario "有効なパスワードとパスワード確認" do
            post password_resets_path, params: { password_reset: { email: @user.email } }
            user = controller.instance_variable_get('@user')
            visit edit_password_reset_path(user.reset_token, email: user.email)
            expect(page).to have_content "パスワード再設定"
            fill_in "user_password",with: "foobar"
            fill_in "user_password_confirmation",with: "foobar"
            find('input[name="commit"]').click
            expect(response).to redirect_to root_url
            expect(page).to have_content "パスワードが再設定されました。"
            expect(page).to have_selector 'div.alert-success'
        end

    end
end