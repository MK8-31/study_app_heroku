require "rails_helper"

RSpec.describe TestMailer, type: :mailer do
  before do
    @user = create(:user)
  end

  describe '#account_activation_mail' do
    subject(:mail) do
      @user.activation_token = User.new_token
      mail = UserMailer.account_activation(@user)
    end
    
    it { expect(mail.from.first).to eq('noreply@example.com') }
    it { expect(mail.to.first).to eq('user@example.com') }
    it { expect(mail.subject).to eq('アカウント有効化') }
    #it { expect(mail.body).to match(/#{@user.name}/) }
  end

  describe '#password_reset_mail' do 
    subject(:pmail) do
      @user.reset_token = User.new_token
      mail = UserMailer.password_reset(@user)
    end
    #.firstとしているのは配列から取り出しているから
    it { expect(pmail.from.first).to eq('noreply@example.com') }
    it { expect(pmail.to.first).to eq('user@example.com') }
    it { expect(pmail.subject).to eq('パスワード再設定') }
  end
end
