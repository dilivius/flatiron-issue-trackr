class IssueNotifier

  attr_accessor :issue

  def initialize(issue)
    @issue = issue
  end

  def execute
    send_email
    send_text
  end

  def send_email
    UserMailer.issue_update_email(issue.user, issue).deliver_now
  end

  def send_text
    owner = issue.repository.user
    if owner.phone_number
      Adapter::TwilioWrapper.new(issue).send_issue_update_text(owner)
    end
  end
end