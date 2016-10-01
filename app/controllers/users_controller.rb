class UsersController < ApplicationController

  def show
    @designs = Design.where(user_id: current_user.id)
    @user = User.find([current_user.id])
  end


  def user_params
  params.require(:user).permit(:avatar)
  end

end
