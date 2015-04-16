class AdministrationController < ApplicationController
  before_filter :authenticate_user!
  before_filter :verify_admin, only: [:index, :services, :users]

  def index
  	@gigs = Gig.all
    @customer_orders = CustomerOrder.all.includes(:gig).order('created_at DESC').page(params[:page]).per(20)
    @pendings = @customer_orders.where(status: 'Pending')
  end

  def services
    @gigs = Gig.all.includes(:user).order('created_at DESC').page(params[:page]).per(20)
  end

  def users
  	@users = User.all.order('created_at DESC').page(params[:page]).per(20)
  end

private
  def verify_admin
    if current_user.role != 'Admin'
      redirect_to root_url, alert: "Sorry, but you're not allowed access to this page."
    end
  end
end