class UsersController < ApplicationController
  before_action :authenticate_user!

  def create
    UserMailer.welcome_email(@user).deliver_now
  end

  def profile
    @user = User.find(current_user.id)
  end
end
