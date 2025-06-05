class UsersController < ApplicationController
  def show
    @user = User.find_by({ "id" => params["id"] })
  end

  def new
    # renders the signup form
  end

  def create
    @user = User.new
    @user["username"] = params["username"]
    @user["email"] = params["email"]

    # encrypt user's password before storing
    @user["password"] = BCrypt::Password.create(params["password"])

    @user.save
    flash["notice"] = "Account created! Please log in."
    redirect_to "/login"
  end
end
