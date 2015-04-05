class DashboardController < ApplicationController
  
  def index
  	@gigs = Gig.all.order('created_at DESC')
  end

  def offers
    @gigs = Gig.where(user: current_user).page(params[:page]).per(10)
  end

  def revenues
  end

  def users
  	@users = User.all
  end

  def allorders
    @gigs = Gig.all
    @orders = Order.all.includes(:gig).page(params[:page]).per(10)
  end

  def listings
    @gigs = Gig.all.order('created_at DESC').page(params[:page]).per(10)
  end

end
