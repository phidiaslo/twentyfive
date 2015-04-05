class WelcomeController < ApplicationController

  def index
  	@gigs = Gig.limit(16).includes(:user)
  	@images = Image.all.order('created_at DESC')
  end

  def privacy
  end

end