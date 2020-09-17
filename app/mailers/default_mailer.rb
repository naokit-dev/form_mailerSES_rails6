class DefaultMailer < ApplicationMailer
  default from: 'naokit.work <noreply@naokit.work>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.default_mailer.test.subject
  #
  def test(user)
    @user = user
    @greeting = "Hi"
    mail to: @user.email
  end
end
