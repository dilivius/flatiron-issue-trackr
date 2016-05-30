# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def issue_update_email
    UserMail.issue_update_email(User.first, Issue.first)
  end
end
