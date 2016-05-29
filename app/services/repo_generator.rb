class RepoGenerator

  def self.generate_repo(params, user)
    repo_owner = params[:url].split("/")[-2]
    repo_name = params[:url].split("/")[-1]
    Repository.new(name: repo_name, url: params[:url], user: user)
  end

end