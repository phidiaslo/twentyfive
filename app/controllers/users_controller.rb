class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:edit, :update, :destrot] # probably want to keep using this
  before_filter :verify_seller_admin, only: [:edit, :update, :destroy]

 
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end
 
  # # GET /users/1
  # # GET /users/1.json
  def show
  end
 
  # GET /users/1/edit
  def edit
  end
 
  # # PATCH/PUT /users/1
  # # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to :back, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
 
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:avatar, :role, :name, :username, :description, :email, :address_one, :address_two, :zipcode, :city, :state, :country, :balance)
    end

    def verify_seller_admin
      if (current_user != @user) && (current_user.role != 'Admin')
        redirect_to root_path, alert: "Sorry, the page you're trying to access belongs to someone else."
      end
    end
 
end