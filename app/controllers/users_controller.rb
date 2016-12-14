class UsersController < ApplicationController
    before_action :authenticate_user!

    def show
        @designs = Design.where(user_id: current_user.id)
        @user = User.find([current_user.id])
        @designs_count = User.eager_load(:designs).group("users.name").count
    end

    def update
    if user_params != nil
      respond_to do |format|
        if current_user.update(user_params)
          format.html { redirect_to user_path , notice: "Tomamos nota. La información ha sido actualizada" }
        else
          flash[:error] = "Hmmm...algo no ha ido como esperábamos, asegúrate de rellenar los campos obligatorios!"
          format.html { redirect_to user_path }
        end
      end
    else
      redirect_to user_path, notice: "Nada que actualizar, sigues siendo el mismo"
    end
  end


private
def user_params
  if params[:user]
    params.require(:user).permit(:first_name, :last_name, :email, :address, :postcode, :city, :avatar)
  end
end
end
