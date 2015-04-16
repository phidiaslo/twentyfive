class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :hook]
  before_action :authenticate_user!
  
  def show
  end

  def new
    @order = Order.new
    @gig = Gig.friendly.find(params[:gig_id])
  end

  def edit
    @gig = Gig.friendly.find(params[:gig_id])
  end

  def create
    @order = Order.new(order_params)
    @gig = Gig.friendly.find(params[:gig_id])
    @seller = @gig.user

    @order.gig_id = @gig.id
    @order.buyer_id = current_user.id
    @order.seller_id = @seller.id
    @order.status = 'Pending'

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order.paypal_url(gig_order_path(@gig, @order)) }
        #format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to allorders_url, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to allorders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def sales
    @gigs = Gig.where(user: current_user)
    @orders = Order.where(seller: current_user, payment_status: 'Paid').includes(:gig).page(params[:page]).per(20)
    @pendings = @orders.where(status: 'Pending')
  end

  def purchases
    @gigs = Gig.all
    @orders = Order.where(buyer: current_user, payment_status: 'Paid').includes(:gig).page(params[:page]).per(20)
  end

  def earnings
    @gigs = Gig.where(user: current_user)
    @orders = Order.where(seller: current_user, status: 'Completed').includes(:gig).page(params[:page]).per(20)
    @pendings = @orders.where(status: 'Pending')
  end

  def edit_order_status
    @order = Order.find(params[:id])
    if params[:commit] == "Pending"
      @order.update(status: "In Progress")
      @order.send_notification_to_buyer
      redirect_to :back, notice: "Status has been succesfully updated to 'In Progress'."
    elsif params[:commit] == "In Progress"
      @order.update(status: "Delivered")
      @order.send_notification_to_buyer
      redirect_to :back, notice: "Status has been succesfully updated to 'Delivered'."
    else params[:commit] == "Delivered"
      @order.update(status: "Completed")      
      @order.send_notification_to_seller
      redirect_to :back, notice: "You have confirmed the completion of this order. Now, you can leave a review to the seller. :)"
    end
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:name, :address_one, :address_two, :state, :zipcode, :city, :country, :email, :gig_id, :buyer_id, :seller_id, :remark, :notification_params, :payment_status, :status, :transaction_id, :purchased_at)
    end
end
