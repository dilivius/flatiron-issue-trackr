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
      # if owner.phone_number
      #   @client = Twilio::REST::Client.new(ENV['TWILIO_SID'], ENV['TWILIO_TOKEN'])
      #   @client.messages.create(
      #     to: owner.phone_number, 
      #     from: "+1 #{ENV['TWILIO_NUMBER']}",
      #      body: "#{issue.title} has been updated. View it here: #{issue.url}")
      # end
  end
end