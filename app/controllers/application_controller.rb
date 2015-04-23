class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :set_global_search_variable
  before_filter :set_global_categories_variable
  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_global_search_variable
    @search = Gig.where(status: 'Active').search(params[:q])
  end

  def set_global_categories_variable
    @users = User.all
    @categories = Category.all
    @subcategories = Subcategory.all
    @pendingcashouts = Cashout.where(status: 'Pending')
  end

  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :avatar, :level, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :avatar, :level, :description, :email, :password, :password_confirmation, :current_password) }
  end
  
end
