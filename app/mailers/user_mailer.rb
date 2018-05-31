class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.verification.subject
  #
  def verification(user)
    @greeting = t('hello')
    @user = user
    mail(
      to: @user.email,
      subject: t('user_mailer.verification.subject')
    )
  end
end
