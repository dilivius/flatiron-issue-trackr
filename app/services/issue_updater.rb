class IssueUpdater

  attr_accessor :issue

  def initialize(payload)
    @payload = payload
    @issue = Issue.find_or_create_by(url: @payload["html_url"])
  end

  def update_from_payload
    update_issue_repo unless issue.repository
    issue.update(title: @payload["title"], content: @payload["body"], assignee: @payload["assignee"], status: @payload["state"])
    issue
  end

  def update_issue_repo
    url_elements = @payload["repository_url"].split("/")
    repo_url = "https://github.com/#{url_elements[-2]}/#{url_elements[-1]}"
    repo = Repository.find_by(url: repo_url)
    issue.update(repository: repo)
  end
end