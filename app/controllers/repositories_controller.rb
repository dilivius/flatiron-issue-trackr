class RepositoriesController < ApplicationController

  def index
    @repositories = current_user.repositories
  end

  def show
    @repository = Repository.find(params[:id])
    if @repository.user == current_user
      render :show
    else
      redirect_to root_path, notice: "you can only view your own repos!"
    end
  end

  def create
    @repo = RepoGenerator.generate_repo(repo_params, current_user)
    if @repo.save
      client = Adapter::GitHub.new(@repo)
      IssueRetriever.get_repo_issues(client, @repo)
      client.create_repo_webhook
    end
    respond_to do |f|
      f.js
      f.html {head :no_content; return}
    end
  end

  private
    def repo_params
      params.require(:repository).permit(:url)
    end
end

