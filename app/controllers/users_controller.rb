class UsersController < ApplicationController

  def show
  end

  def user_params
  params.require(:user).permit(:avatar)
  end

end
