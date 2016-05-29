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
end