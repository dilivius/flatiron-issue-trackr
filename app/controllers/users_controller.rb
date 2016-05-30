class UsersController < ApplicationController

  before_action :set_user, only: [:update]

  def show
    @user = UserDecorator.new(current_user)
  end

  def update
    if @user == current_user
      @user.phone_number = user_params[:phone_number]
      if @user.save
        respond_to do |f|
          f.js
        end
      else
        respond_to do |f|
          f.js {render 'phone_errors.js.erb'}
        end
      end
    end
  end

  private

    def user_params
      params.require(:user).permit(:phone_number)
    end

    def set_user
      @user = UserDecorator.new(User.find(params[:id]))
    end
end
