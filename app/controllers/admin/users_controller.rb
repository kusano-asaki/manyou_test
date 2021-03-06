class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :if_not_admin, only: [:index, :new, :show, :create, :edit, :update, :detroy]

  def index
    @users = User.all.includes(:tasks).order(created_at:'DESC') #.order(id: "ASC")
  end

  def new
    @user = User.new
  end

  def show
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'Userを作成しました'
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user.id)
      flash[:notice] = 'User情報を更新しました'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path
    flash[:notice] = 'User情報を削除しました'
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

     def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
    end

    def if_not_admin
      if logged_in?
      redirect_to root_path, notice:'あなたは管理者ではありません'  unless current_user.admin?
        else
          redirect_to new_session_path
      end
    end
end
