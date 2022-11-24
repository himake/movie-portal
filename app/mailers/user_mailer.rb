class UserMailer < ApplicationMailer
  default from: 'Test <test@example.com>'

  layout 'mailer'

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'From Movie-portal with love')
  end

  def test_send(email)
    @email = email
    mail(to: @email, subject: 'Test Send')
  end
end
