require 'rails_helper'

RSpec.describe "予定表テスト",type: :system do
    include TestHelper

    before do
        @user = create(:user)
        @notice = @user.notifications.create!(start_time: DateTime.now,subject: "math",homework_test: false,over: false)
    end

    let(:login) { log_in_as(@user) }
    let(:subject) { @subject = @user.subjects.create!(name: "english",day_of_week: "Monday",th_period: 1,definitely: false) }

    context "予定追加" do
        scenario "無効な送信（すべて空）" do
            login
            visit notifications_new_path
            fill_in "notification_subject",with: ""
            fill_in "notification_start_time",with: ""
            find('input[name="commit"]').click
            expect(page).to have_selector 'div.alert-danger'
        end
        
        scenario "無効な送信（予定名が空の場合）" do
            login
            visit notifications_new_path
            fill_in "notification_subject",with: ""
            fill_in "notification_start_time",with: DateTime.now
            find('input[name="commit"]').click
            expect(page).to have_selector 'div.alert-danger'
        end

        scenario "無効な送信（予定日が空の場合）" do
            login
            visit notifications_new_path
            fill_in "notification_subject",with: "math"
            fill_in "notification_start_time",with: ""
            find('input[name="commit"]').click
            expect(page).to have_selector 'div.alert-danger'
        end

        scenario "有効な送信" do
            login
            visit notifications_new_path(homework_test: false)
            expect{
                fill_in "notification_subject",with: "math"
                fill_in "notification_start_time",with: DateTime.now
                find('input[name="commit"]').click
            }.to change{ Notification.count }.by(1)
            expect(page).to have_selector 'div.alert-success'
        end

        scenario "有効な送信（時間割から追加）" do
            login
            subject
            visit subjects_path
            expect(page).to have_content "課題"
            click_on "課題"
            sleep 1.0
            expect(page).to have_content "課題予定追加"
            expect{
                fill_in "notification_start_time",with: DateTime.now
                find('input[name="commit"]').click
            }.to change{ Notification.count }.by(1)
            expect(page).to have_selector 'div.alert-success'
        end
    end

    context "予定編集" do
        scenario "無効な送信（予定名が空の場合）" do
            login
            visit edit_notification_path(@notice)
            fill_in "notification_subject",with: ""
            find('input[name="commit"]').click 
            expect(page).to have_selector 'div.alert-danger'
        end

        scenario "有効な送信" do
            login
            visit edit_notification_path(@notice)
            fill_in "notification_subject",with: "abc"
            # select '',from: "notification_start_time_1i"
            # select '',from: "notification_start_time_2i"
            # select '',from: "notification_start_time_3i"
            # select '',from: "notification_start_time_4i"
            # select '',from: "notification_start_time_5i"
            find('input[name="commit"]').click 
            expect(page).to have_selector 'div.alert-success'
            expect(page).to have_content "abc"
        end
    end

    context "予定削除" do
        scenario "有効な削除" do
            login
            expect(page).to have_selector 'div.alert-success'
            expect(@notice.valid?).to eq true
            visit notification_path(@notice)
            expect(page).to have_content "課題詳細"
            expect{
                click_on "削除"
            }.to change{ Notification.count }.by(-1)
            expect(page).to have_selector 'div.alert-success'
        end
    end
end