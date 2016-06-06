class NotificationsJob < ActiveJob::Base
  queue_as :default

  def perform(issue)
    IssueNotifier.new(issue).execute
  end
end
