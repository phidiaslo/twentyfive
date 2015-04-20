class GigsController < ApplicationController
  include GigsHelper
  before_action :set_gig, only: [:show, :edit, :update, :destroy]
  before_filter :verify_seller_admin, only: [:edit, :update, :destroy]


  def index
    @gigs = Gig.all.page(params[:page]).per(20)
    @gigs = @search.result(distinct: true).page(params[:page]).per(20)
    @image = Image.where(gig_id: @gig)
  end

  def search
    @gigs = @search.result.includes(:user)
    @images = Image.all.order('created_at DESC')
  end

  def offers
    @gigs = Gig.where(user: current_user)
  end

  def sales
    @gigs = Gig.where(user: current_user)
  end

  def revenues
    @gigs = Gig.where(user: current_user)
  end

  def show
    @images = Image.all.order('created_at DESC').includes(:gig)
    @image = Image.where(gig_id: @gig)
    
    if user_signed_in?
      if (current_user.id != @gig.user_id) && (current_user.role != 'Admin')
        @gig.increment!(:view_count)
      end
    else
      @gig.increment!(:view_count)
    end
  end

  def new
    @gig = Gig.new
    
    6.times do
      @gig.images.build
    end
    
    @categories = Category.all
    @subcategories = Subcategory.all
  end

  def update_subcategories
    category = Category.find(params[:category_id])
    @subcategories = category.subcategories.map{|a| [a.name, a.id]}.insert(0, "Select Subcategory")
  end

  def edit
    image_number = 6 - @gig.images.size
    image_number.times do
    @gig.images.build
    end
  end

  def create
    @gig = Gig.new(gig_params)
    @gig.user_id = current_user.id
    @gig.status = 'Active'

    respond_to do |format|
      if @gig.save
        format.html { redirect_to @gig, notice: 'Service was successfully created.' }
        format.json { render :show, status: :created, location: @gig }
      else
        format.html { render :new }
        format.json { render json: @gig.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    #@gig.update(gig_params)
    #respond_with(@gig)

    respond_to do |format|
      if @gig.update(gig_params)
        format.html { redirect_to @gig, notice: 'Service was successfully updated.' }
        format.json { render :show, status: :ok, location: @gig }
      else
        format.html { render :edit }
        format.json { render json: @gig.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @gig.destroy
    #respond_with(@gig)
    respond_to do |format|
      format.html { redirect_to gigs_url, notice: 'Gig was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def edit_individual
    @gigs = Gig.find(params[:gig_ids])

    if params[:commit] == 'Delete'
      @gigs.each { |gig|
        Gig.destroy(gig.id)  }
    elsif params[:commit] == 'Activate'
      @gigs.each { |gig|
        gig.status = 'Active'
        gig.save 
      } 
    elsif params[:commit] == 'Deactivate'
      @gigs.each { |gig|
        gig.status = 'Inactive'
        gig.save 
      }
    else params[:commit] == 'Ban'
        @gigs.each { |gig|
          gig.status = 'Banned'
          gig.save 
        }
    end
    redirect_to :back
  end

  #def update_individual
  #  @gigs = Gig.update(params[:gigs].keys, params[:gigs].values).reject { |p| p.errors.empty? }
  #      if @gigs.empty?
  #       flash[:notice] = "Gigs updated"
  #        redirect_to offers_path
  #      else
  #        render :action => "edit_individual"
  #     end
  #end

  private
    def set_gig
      @gig = Gig.friendly.find(params[:id])
    end

    def gig_params
      params.require(:gig).permit(:gig_title, :featured, :category, :description, :duration, :processing_time, :cover, :video, :admin_disable, :slug, :category_id, :subcategory_id, images_attributes: [ :id, :graphic ], subcategories_attributes: [ :id, :name, :category_id])
    end

    def verify_seller_admin
      if (current_user != @gig.user) && (current_user.role != 'Admin')
        redirect_to root_url, alert: "Sorry, the page you're trying to access belongs to someone else."
      end
    end
end