require 'rails_helper'

RSpec.describe "時間割テスト",type: :system do
    include TestHelper

    before do
        @user = create(:user)
        @subject = @user.subjects.create!(name: "english",day_of_week: "Tuesday",th_period:1,definitely: false)
    end

    let(:login) { log_in_as(@user) }

    context "時間割追加" do
        scenario "無効な送信（全部空）" do
            login
            visit subjects_new_path
            expect(page).to have_content "追加"
            find('input[name="commit"]').click
            expect(page).to have_content "4つのエラーがあります。"
        end

        scenario "無効な送信（科目名を空にする）" do
            login
            visit subjects_new_path
            expect(page).to have_content "追加"
            select "月曜日",from: "subject_day_of_week"
            select '1',from: "subject_th_period"
            find('input[name="commit"]').click
            expect(page).to have_selector 'div.alert-danger'
        end
        scenario "無効な送信（曜日を空にする）" do
            login
            visit subjects_new_path
            expect(page).to have_content "追加"
            fill_in "subject_name",with: "電子回路"
            select '1',from: "subject_th_period"
            find('input[name="commit"]').click
            expect(page).to have_selector 'div.alert-danger'
        end
        scenario "無効な送信（時限を空にする）" do
            login
            visit subjects_new_path
            expect(page).to have_content "追加"
            fill_in "subject_name",with: "電子回路"
            select "月曜日",from: "subject_day_of_week"
            find('input[name="commit"]').click
            expect(page).to have_selector 'div.alert-danger'
        end

        scenario "有効な送信" do
            login
            # visit root_path
            # expect(page).to_not have_content "登録"
            # expect(page).to_not have_content "今すぐ登録！"
            # find('a.dropdown-toggle',text: "時間割").click
            # expect(page).to have_content "時間割追加"
            # click_on "時間割追加"
            visit subjects_new_path
            expect(page).to have_content "追加"
            fill_in "subject_name",with: "電子回路"
            select "月曜日",from: "subject_day_of_week"
            select '1',from: "subject_th_period"
            find('input[name="commit"]').click
            expect(page).to have_selector 'div.alert-success'
        end
    end

    context "時間割編集" do
        scenario "無効な送信（科目名を空にする）" do
            login
            visit edit_subject_path(@subject)
            expect(page).to have_content "編集"
            fill_in "subject_name",with: ""
            find('input[name="commit"]').click
            expect(page).to have_selector 'div.alert-danger'
        end

        scenario "有効な送信" do
            login
            # visit root_path
            # expect(page).to_not have_content "登録"
            # expect(page).to_not have_content "今すぐ登録！"
            # find('a.dropdown-toggle',text: "時間割").click
            # expect(page).to have_content "時間割を編集"
            # click_on "時間割を編集"
            # click_on "編集"
            visit edit_subject_path(@subject)
            fill_in "subject_name",with: "math"
            find('input[name="commit"').click
            expect(page).to have_selector 'div.alert-success'
        end
    end

    context "時間割削除" do
        scenario "有効な削除" do
            login
            # visit root_path
            # expect(page).to have_selector('h1',text: "最高の時間管理を",visible: false)
            # #トグルの時間稼ぎに３つ必要だった
            # expect(page).to_not have_content "登録"
            # expect(page).to_not have_content "今すぐ登録！"
            # find('a.dropdown-toggle',text: "時間割").click
            # expect(page).to have_content "時間割を編集"
            # click_on "時間割を編集"
            visit subjects_show_path
            expect{click_on "削除"}.to change{ Subject.count }.by(-1)
            expect(page).to have_content "消去しました"
            expect(page).to have_selector 'div.alert-success'
        end

        scenario "有効なリセット（全削除）" do
            login
            # visit root_path
            # expect(page).to have_selector('h1',text: "最高の時間管理を",visible: false)
            # expect(page).to_not have_content "登録"
            # expect(page).to_not have_content "今すぐ登録！"
            # find('a.dropdown-toggle',text: "時間割").click
            # expect(page).to have_content "時間割を編集"
            # click_on "時間割を編集"
            visit subjects_show_path
            page.accept_confirm("時間割をリセットします。よろしいですか？") do
                click_on "リセット"
            end
            expect(page).to have_content "リセットしました。"
            expect(page).to have_selector 'div.alert-success'
            expect( Subject.count ).to eq 0
        end

        
    end
end