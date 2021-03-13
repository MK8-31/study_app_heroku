require 'rails_helper'

RSpec.describe Notification, type: :model do
  before do
    @user = create(:user)
    @notice = @user.notifications.create!(subject: "math1",start_time: DateTime.now,homework_test: false,over: false)
  end

  let(:notices) {
    49.times do |n|
      @user.notifications.create!(subject: "math#{n+2}",start_time: DateTime.now.prev_day(n+1),homework_test: false,over: false)
    end
  }

  describe 'Notificationバリデーション' do
    it 'subjectが空だとNG' do
      @notice.subject = ' '
      expect(@notice.valid?).to eq(false)
    end

    it 'start_timeが空だとNG' do
      @notice.start_time = ' '
      expect(@notice.valid?).to eq(false)
    end

    it 'subjectは20文字以内' do
      @notice.subject = 'a'*21
      expect(@notice.valid?).to eq(false)
    end

    it "ユーザー１人当たりが持てるnotification(over: false)の数は50こ" do
      notices
      expect(@user.notifications.count).to eq(50)
      expect(@user.notifications.find_by(subject: "math3").valid?).to eq(true)
      expect(@user.notifications.find_by(subject: "math2").valid?).to eq(true)
      expect(@user.notifications.find_by(subject: "math49").valid?).to eq(true)
      expect(@user.notifications.find_by(subject: "math50").valid?).to eq(true)
      expect(
        @user.notifications.create!(subject: "math51",start_time: DateTime.now.prev_day(50),homework_test: false,over: false).valid?
      ).to eq(false)
    end
  end
end
