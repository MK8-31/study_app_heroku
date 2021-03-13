require 'rails_helper'

RSpec.describe "学習時間テスト",type: :system do
    include TestHelper

    before do
        @user = create(:user)
        @studytime = @user.studytimes.create(day: Date.yesterday,time: 60,ctime: 30)
    end

    let(:login) { log_in_as(@user) }

    context "学習時間記録" do

        scenario "無効な送信（全部空）" do
            login
            visit studytimes_new_path
            expect(page).to have_content "学習時間記録"
            fill_in "studytime_day",with: ""
            find('input[name="commit"]').click
            expect(page).to have_selector 'div.alert-danger'
        end

        scenario "無効な送信（日付が空）" do
            login
            visit studytimes_new_path
            expect(page).to have_content "学習時間記録"
            fill_in "studytime_day",with: ""
            fill_in "studytime_time",with: '60'
            fill_in "studytime_ctime",with: '30'
            find('input[name="commit"]').click
            expect(page).to have_selector 'div.alert-danger'
        end

        scenario "無効な送信（合計時間が空）" do
            login
            visit studytimes_new_path
            expect(page).to have_content "学習時間記録"
            fill_in "studytime_time",with: ''
            fill_in "studytime_ctime",with: '30'
            find('input[name="commit"]').click
            expect(page).to have_selector 'div.alert-danger'
        end

        scenario "無効な送信（集中できた時間が空）" do
            login
            visit studytimes_new_path
            expect(page).to have_content "学習時間記録"
            fill_in "studytime_time",with: '60'
            fill_in "studytime_ctime",with: ''
            find('input[name="commit"]').click
            expect(page).to have_selector 'div.alert-danger'
        end

        scenario "有効な送信" do
            login
            visit root_path
            # expect(page).to have_selector('h1',text: "最高の時間管理を",visible: false)
            # expect(page).to_not have_content "登録"
            # expect(page).to_not have_content "今すぐ登録！"
            # find('a.dropdown_toggle',text: "学習時間").click
            # expect(page).to have_content "記録する"
            # click_on "記録する"
            visit studytimes_new_path
            expect(page).to have_content "学習時間記録"
            fill_in "studytime_time",with: '60'
            fill_in "studytime_ctime",with: '30'
            find('input[name="commit"]').click
            expect(page).to have_selector 'div.alert-success'
        end
    end

    context "学習時間編集" do
        scenario "無効な送信（すべてが空）" do
            login
            visit edit_studytime_path(@studytime)
            expect(page).to have_content "学習時間編集"
            fill_in "studytime_day",with: ''
            fill_in "studytime_time",with: ''
            fill_in "studytime_ctime",with: ''
            find('input[name="commit"').click
            expect(page).to have_selector 'div.alert-danger'
        end

        scenario "無効な送信（日付が空）" do
            login
            visit edit_studytime_path(@studytime)
            expect(page).to have_content "学習時間編集"
            fill_in "studytime_day",with: ''
            find('input[name="commit"]').click
            expect(page).to have_selector 'div.alert-danger'
        end

        scenario "無効な送信（集中できた時間が空）" do
            login
            visit edit_studytime_path(@studytime)
            expect(page).to have_content "学習時間編集"
            fill_in "studytime_time",with: '60'
            fill_in "studytime_ctime",with: ''
            find('input[name="commit"]').click
            expect(page).to have_selector 'div.alert-danger'
        end

        scenario "無効な送信（合計時間が空）" do
            login
            visit edit_studytime_path(@studytime)
            expect(page).to have_content "学習時間編集"
            fill_in "studytime_time",with: ''
            fill_in "studytime_ctime",with: '30'
            find('input[name="commit"]').click
            expect(page).to have_selector 'div.alert-danger'
        end

        scenario "有効な送信" do
            login
            visit edit_studytime_path(@studytime)
            expect(page).to have_content "学習時間編集"
            fill_in "studytime_time",with: '60'
            fill_in "studytime_ctime",with: '30'
            find('input[name="commit"]').click
            expect(page).to have_selector 'div.alert-success'
        end
    end

    context "学習時間削除" do
        scenario "有効な削除" do
            login
            visit studytimes_path 
            expect{click_on '削除'}.to change{ Studytime.count }.by(-1)
            expect(page).to have_selector 'div.alert-success'
            expect(page).to have_content "削除しました"
        end
    end
end