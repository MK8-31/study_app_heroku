class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation(user)
    @user = user
    mail to: user.email,subject: "アカウント有効化"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail to: user.email,subject: "パスワード再設定"
  end

  def remind(user,notice)
    @user = user
    @notice = notice
    if @notice.homework_test?
      @homework_test = "テストがあります。"
    else
      @homework_test = "課題の提出期限です。"
    end

    mail to: user.email,subject: "通知"
  end 
end
