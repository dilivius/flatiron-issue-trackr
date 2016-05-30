# require_relative './github.rb'
module Adapter
  class GitHub

    attr_accessor :repo

    def initialize(repo)
      @client ||= Octokit::Client.new(access_token: ENV["GITHUB_TOKEN"])
      @repo = repo
    end

    def repo_issues
      @client.issues("#{repo.user.github_username}/#{repo.name}")
    end

    def create_repo_webhook
      @client.create_hook("#{repo.user.github_username}/#{repo.name}",
        'web',
        {url: "#{ENV['ISSUE_TRACKR_APP_URL']}/webhooks/receive", content_type: 'json'},
        {events: ['issues'], active: true})
    end
  end

  class TwilioWrapper

    attr_accessor :issue

    def initialize(issue)
      @client = Twilio::REST::Client.new(ENV['TWILIO_SID'], ENV['TWILIO_TOKEN']) 
      @issue = issue
    end

    def send_issue_update_text(owner)
      @client.messages.create(
        to: owner.phone_number, 
        from: "+1 #{ENV['TWILIO_NUMBER']}",
        body: "#{issue.title} has been updated. View it here: #{issue.url}")
    end
  end
end