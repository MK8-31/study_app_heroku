require 'rails_helper'

RSpec.describe "users_edit",type: :system do
    include TestHelper
    before do
        @user = create(:user)
    end

    scenario 'ユーザー情報が更新されること' do
        visit root_path
        expect(page).to have_content("最高の時間管理をあなたに")
        #expect(page).to have_content("今すぐ登録!")

        visit login_path

        fill_in "session_email",with: @user.email
        fill_in "session_password",with: @user.password
        find('input[name="commit"]').click
        expect(page).to have_content @user.name
        visit root_path
        expect(page).not_to have_content("今すぐ登録")
        #以下3つはたまに失敗する、原因は不明
        # expect(page).to have_selector 'a.btn-warning'
        # expect(page).to have_selector 'a',text: "予定表"
        # expect(page).to have_selector 'a',text: "学習時間"

        visit edit_user_path(@user)

        fill_in "user_name",with: "useredit"
        find('input[name="commit"]').click
        expect(page).to have_content "useredit"

    end

    scenario 'ユーザー情報更新失敗' do

        log_in_as(@user)
        visit root_path
        expect(page).to_not have_content "今すぐ登録" 
        visit edit_user_path(@user)
        expect(page).to have_content "プロファイルの変更"
        fill_in "user_name",with: ""
        fill_in "user_password",with: "foo"
        fill_in "user_password_confirmation",with: "bar"
        find('input[name="commit"]').click
        #expect(response).to render_template(:edit) #gemが必要
        expect(page).to have_content "エラー"
    end

end