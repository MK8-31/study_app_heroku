require 'rails_helper'

RSpec.describe User, type: :model do
    before do 
        @user = create(:user)
    end

    describe 'バリデーション' do
        subject { @user.valid? }
        it 'nameとemailどちらも値が設定されていれば、OK' do
            is_expected.to eq(true)
        end

        it 'nameが空だとNG' do
            @user.name = ''
            is_expected.to eq(false)
        end

        it 'emailが空だとNG' do
            @user.email = ''
            is_expected.to eq(false)
        end

        it 'nameは50文字以内' do
            @user.name = 'a'*51
            is_expected.to eq(false)
        end

        it 'emailは255文字以内' do
            @user.email = 'a'*244 + '@example.com'
            is_expected.to eq(false)
        end

        it 'emailがメールアドレスの形をしているか(valid_address)' do
            valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                first.last@foo.jp alice+bob@baz.cn]
            valid_addresses.each do |valid_address|
                @user.email = valid_address
                is_expected.to eq(true),"#{valid_address.inspect} should be valid"
            end
        end

        it 'emailがメールアドレスの形をしているか(invalid_address)' do
            invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                foo@bar_baz.com foo@bar+baz.com]
            invalid_addresses.each do |invalid_address|
                @user.email = invalid_address
                is_expected.to eq(false), "#{invalid_address.inspect} should be invalid"
            end           
        end

        it 'userが一意かどうか' do
            duplicate_user = @user.dup
            @user.save
            expect(duplicate_user.valid?).to eq(false)
        end

        it 'passwordが空だとNG' do
            @user.password = " "*6
            is_expected.to eq(false)
        end

        it 'passwordは6文字以上' do
            @user.password = "a"*5
            @user.password_confirmation = "a"*5
            is_expected.to eq(false)
        end

        it 'authenticated? should return false for a user with nil digest' do
            expect(@user.authenticated?(:remember,'')).to eq(false)
        end

        it 'userと連携してsubjectも消去' do
            @user.save
            @user.subjects.create!(name: "math",day_of_week: "Monday",th_period: 1,definitely: true)
            expect{@user.destroy}.to change{ Subject.count }.by(-1)
        end

        it 'userと連携してstudytimeも消去' do
            @user.save
            @user.studytimes.create!(day: Date.today,time: 20,ctime: 10)
            expect{ @user.destroy }.to change{ Studytime.count }.by(-1)
        end

        it 'userと連携してnotificationも消去' do
            @user.save
            @user.notifications.create!(start_time: DateTime.now,subject: "math",homework_test: false,over: false)
            expect{ @user.destroy }.to change{ Notification.count }.by(-1)
        end

        it 'userと連携してreminderも消去' do
            @user.save
            notice = @user.notifications.create!(start_time: DateTime.now,subject: "math",homework_test: false,over: false)
            Reminder.create!(notification_id: notice.id,user_id: @user.id,action: "warning")
            expect{ @user.destroy }.to change{ Reminder.count }.by(-1)
        end
    end
end