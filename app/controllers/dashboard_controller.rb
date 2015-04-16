class DashboardController < ApplicationController
  before_filter :authenticate_user!, only: [:offers, :revenues]
  
  def services
    @gigs = Gig.where(user: current_user).page(params[:page]).per(10)
    @customer_orders = CustomerOrder.where(seller: current_user, payment_status: 'Paid').includes(:gig).page(params[:page]).per(20)
    @pendings = @customer_orders.where(seller: current_user, status: 'Pending')
  end

  def allorders
    @gigs = Gig.all
    @customer_orders = CustomerOrder.all.includes(:gig).page(params[:page]).per(20)
    @pendings = @orders.where(status: 'Pending')
  end

  def listings
    @gigs = Gig.all.order('created_at DESC').page(params[:page]).per(10)
  end

end
