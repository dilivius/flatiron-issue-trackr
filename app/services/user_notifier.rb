class UserNotifier
  attr_accessor :issue

  def initialize(issue)
    @issue = issue
  end

  def notify
    send_update_email
    send_update_text
  end

  def send_update_email
    UserMailer.issue_update_email(issue.user, issue).deliver_now
  end

  def send_update_text
    owner = issue.repository.user
    if owner.phone_number
      Adapter::TwilioWrapper.new(issue).create_issue_text
    end
  end
end