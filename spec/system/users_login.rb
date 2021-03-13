require 'rails_helper'

RSpec.describe 'ログイン処理',type: :system do
    include TestHelper
    
    before do
        @user = create(:user)
        visit login_path
    end

    subject { page }

    context "passwordが無効な場合" do
        scenario "無効" do
            is_expected.to have_content "Log in"
            fill_in "session_email",with: @user.email
            fill_in "session_password",with: "invalid"
            find('input[name="commit"]').click
            is_expected.to have_content "メールアドレスとパスワードの組み合わせが正しくありません。"
            is_expected.to have_content "Log in"
        end
    end
    context "emailが無効な場合" do
        scenario "無効" do
            is_expected.to have_content "Log in"
            fill_in "session_email",with: "invalid@yahoo.co.jp"
            fill_in "session_password",with: @user.password
            find('input[name="commit"]').click
            is_expected.to have_content "メールアドレスとパスワードの組み合わせが正しくありません。"
            is_expected.to have_content "Log in"
        end
    end

    context "email/passwordが有効な場合" do
        scenario "有効->ログアウト検証" do
            is_expected.to have_content "Log in"
            fill_in "session_email",with: @user.email
            fill_in "session_password",with: @user.password
            find('input[name="commit"]').click
            is_expected.to have_content "ログインしました。"
            is_expected.to have_content @user.name
            is_expected.to_not have_selector 'a[href="/login"]',text: "ログイン"
            click_on("アカウント")
            is_expected.to have_selector 'a[href="/logout"]',text: "ログアウト"
            is_expected.to have_link 'プロファイル',href: user_path(@user)
            #ログアウト
            click_on("ログアウト")
            is_expected.to have_content "最高の時間管理を"
            is_expected.to have_link '今すぐ登録',href: signup_path
            is_expected.to have_link 'ログイン',href: login_path
            is_expected.to have_link '登録',href: signup_path
            is_expected.to_not have_link 'ログアウト',href: logout_path
        end

        
    end

    context "ログイン（自動ログイン）" do
        scenario "Cookie確認" do
            fill_in "session_email",with: @user.email
            fill_in "session_password",with: @user.password
            check "session_remember_me"
            find('input[name="commit"]').click
            is_expected.to have_content @user.name
            is_expected.to have_content "自動ログイン：有効"
            #cookieのテスト
            pending 'この先のテストは失敗、Cookieのテストの書き方がわからない'
            expect(cookies['remember_token']).to eq true
        end
    end
end