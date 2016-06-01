class IssuesController < ApplicationController

  def index
    @issues = current_user.issues
  end

  def show
    @issue = Issue.find(params[:id])
    @repository = RepositoryDecorator.new(@issue.repository)
    if @issue.user == current_user
      render :show
    else
      redirect_to root_path, notice: "you can only view your own issues!"
    end
  end
end
