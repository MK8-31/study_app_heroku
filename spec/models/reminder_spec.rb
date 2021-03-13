require 'rails_helper'

RSpec.describe Reminder, type: :model do
  before do
    @user = create(:user)
    @notice = @user.notifications.create!(subject: "math",start_time: DateTime.now,homework_test: false,over: false)
    @reminder = Reminder.create!(user_id: @user.id,notification_id: @notice.id,action: "warning")
  end

  describe 'Reminderバリデーション' do
    it 'actionが空だとNG' do
      @reminder.action = " "
      expect(@reminder.valid?).to eq(false)
    end
  end
end
