class Admin::UsersController < ApplicationController

  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_users_url, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: [:admin,@user] }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(params[:user].permit(:name, :address, :email))
      redirect_to admin_user_path
    else
      render 'edit'
    end
  end
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_path
  end
  private

  def user_params
    params.require(:user).permit(:name, :email, :address, :password)
  end
  
end