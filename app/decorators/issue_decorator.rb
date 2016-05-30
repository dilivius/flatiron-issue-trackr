class IssueDecorator < SimpleDelegator
  def pretty_date
    opened_on.strftime("%A, %d %b %Y %l:%M %p")
  end

  def display_assignee
    return "n/a" unless assignee
  end
end