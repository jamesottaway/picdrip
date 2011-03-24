class UsersController < ApplicationController
  # GET /user
  def show
    @user = current_user
  end

  # GET /users/1/edit
  def edit
    @user = current_user
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    if @user == current_user && @user.update_attributes(params[:user])
      redirect_to(user_path, :notice => 'User was successfully updated.')
    else
      render :action => "edit"
    end
  end
end
