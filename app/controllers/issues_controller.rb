class IssuesController < ApplicationController

  def index
    @issues = current_user.issues
  end

  def show
    @issue = IssueDecorator.new(Issue.find(params[:id]))
    if @issue.user == current_user
      @repository = RepositoryDecorator.new(@issue.repository)
      render :show
    else
      redirect_to root_path, notice: "you can only view your own issues!"
    end
  end
end
