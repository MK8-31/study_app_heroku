require 'rails_helper'

RSpec.describe "通知",type: :system do
    include TestHelper

    before do
        @user = create(:user)
        @notice = @user.notifications.create(subject: "math",start_time: DateTime.now,homework_test: false,over: false)
    end

    let(:login) { log_in_as(@user) }

    context "通知追加" do
        scenario "有効な送信" do
            login
            Reminder.create(notification_id: @notice.id,user_id: @user.id,action: "warning")
            visit reminders_path
            expect(page).to have_content @notice.subject
        end
    end
end