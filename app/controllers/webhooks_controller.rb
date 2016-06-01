class WebhooksController < ApplicationController

  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate

  def receive
    if params[:zen]
      head :no_content
      return
    else
      issue = IssueUpdater.new(issue_params).update
      UserNotifier.new(issue).notify
      head :no_content
      return
    end
  end

  private

    def issue_params
      params["issue"]
    end
end
