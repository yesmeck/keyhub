class UsersController < ApplicationController
  before_action :require_login, :set_user

  def profile
  end

  def update
    @user.update(user_params)

    redirect_to profile_path
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:username, :email, :preferred_shell, :ssh_public_key)
  end
end
