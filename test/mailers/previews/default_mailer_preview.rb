# Preview all emails at http://localhost:3000/rails/mailers/default_mailer
class DefaultMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/default_mailer/test
  def test
    DefaultMailer.test
  end

end
