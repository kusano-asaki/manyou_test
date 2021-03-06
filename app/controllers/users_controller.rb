class UsersController < ApplicationController
  def new
    if logged_in?
      redirect_to user_path(current_user.id)
      flash[:notice] = 'ユーザー登録済みです'
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = 'ログインしました'
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to tasks_path, notice:'他のユーザーへのアクセスはできません'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
