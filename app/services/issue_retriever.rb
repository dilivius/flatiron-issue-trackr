class IssueRetriever
  def self.get_repo_issues(client, repo)
    issues = client.repo_issues
    issues.each do |issue|
      Issue.create(url: issue.html_url, opened_by: issue.user.login, status: issue.state, title: issue.title, content: issue.body, opened_on: issue.created_at, assignee: issue.assignee, repository: repo)
    end
  end
end