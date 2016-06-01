class IssueUpdater
  attr_accessor :issue, :issue_payload

  def initialize(issue_params)
    @issue = Issue.find_or_create_by(url: issue_params["html_url"])
    @issue_payload = issue_params
  end

  def update
    associate_repo unless issue.repository
    update_issue
    issue
  end

  def associate_repo
    url_elements= issue_payload["repository_url"].split("/")
        repo_url = "https://github.com/#{url_elements[-2]}/#{url_elements[-1]}"
        repo = Repository.find_by(url: repo_url)
        issue.update(repository: repo)
  end

  def update_issue
    issue.update(title: issue_payload["title"], content: issue_payload["body"], assignee: issue_payload["assignee"], status: issue_payload["state"])
  end
end