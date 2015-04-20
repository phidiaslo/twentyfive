class WelcomeController < ApplicationController

  def index
  	@gigs = Gig.where(featured: true, status: 'Active').limit(16).includes(:user)
  	@images = Image.all.order('created_at DESC')
  end

  def privacy
  end

end