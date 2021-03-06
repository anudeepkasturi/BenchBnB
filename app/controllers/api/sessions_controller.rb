class Api::SessionsController < ApplicationController

  def create
    @user = User.find_by_credentials(
      session_params[:username],
      session_params[:password]
    )

    if @user
      login(@user)
      render "api/users/show"
    else
      render json: ["Invalid username or password"], status: 422
    end
  end

  def destroy
    if current_user
      current_user.reset_session_token!
      logout
      render json: {}
    else
      render json: ["No one logged in"], status: 404
    end
  end

  private
  def session_params
    params.require(:user).permit(:username, :password)
  end
end
