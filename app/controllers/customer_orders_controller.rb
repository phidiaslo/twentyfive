class CustomerOrdersController < ApplicationController
  before_action :set_customer_order, only: [:show, :edit, :update, :destroy]

  # GET /customer_orders/1
  # GET /customer_orders/1.json
  def show
  end

  # GET /customer_orders/new
  def new
    @customer_order = CustomerOrder.new
    @gig = Gig.friendly.find(params[:gig_id])
  end

  # GET /customer_orders/1/edit
  def edit
    @gig = Gig.friendly.find(params[:gig_id])
  end

  # POST /customer_orders
  # POST /customer_orders.json
  def create
    @customer_order = CustomerOrder.new(customer_order_params)
    @gig = Gig.friendly.find(params[:gig_id])
    @seller = @gig.user

    @customer_order.gig_id = @gig.id
    @customer_order.buyer_id = current_user.id
    @customer_order.seller_id = @seller.id
    @customer_order.status = 'Pending'

    respond_to do |format|
      if @customer_order.save
        format.html { redirect_to @customer_order.paypal_url(gig_customer_order_path(@gig, @customer_order)) }
        #format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @customer_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customer_orders/1
  # PATCH/PUT /customer_orders/1.json
  def update
    respond_to do |format|
      if @customer_order.update(customer_order_params)
        format.html { redirect_to @customer_order, notice: 'Customer order was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer_order }
      else
        format.html { render :edit }
        format.json { render json: @customer_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customer_orders/1
  # DELETE /customer_orders/1.json
  def destroy
    @customer_order.destroy
    respond_to do |format|
      format.html { redirect_to admin_url, notice: 'Customer order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def sales
    @gigs = Gig.where(user: current_user)
    @customer_orders = CustomerOrder.where(seller: current_user, payment_status: 'Paid').includes(:gig, :buyer).order('created_at DESC').page(params[:page]).per(20)
    @pendings = @customer_orders.where(status: 'Pending')
  end

  def purchases
    @gigs = Gig.all
    @customer_orders = CustomerOrder.where(buyer: current_user, payment_status: 'Paid').includes(:gig, :buyer, :seller).order('purchased_at DESC').page(params[:page]).per(20)
  end

  def earnings
    @gigs = Gig.where(user: current_user)
    @customer_orders = CustomerOrder.where(seller: current_user, status: 'Completed').includes(:gig, :seller).order('purchased_at DESC').page(params[:page]).per(20)
    @pendings = @customer_orders.where(status: 'Pending')
  end

  def edit_customer_order_status
    @customer_order = CustomerOrder.find(params[:id])
    if params[:commit] == "Pending"
      @customer_order.update(status: "In Progress")
      @customer_order.send_notification_to_buyer
      redirect_to :back, notice: "Status has been succesfully updated to 'In Progress'."
    elsif params[:commit] == "In Progress"
      @customer_order.update(status: "Delivered")
      @customer_order.send_notification_to_buyer
      redirect_to :back, notice: "Status has been succesfully updated to 'Delivered'."
    else params[:commit] == "Delivered"
      @customer_order.update(status: "Completed")      
      @customer_order.send_notification_to_seller
      redirect_to :back, notice: "You have confirmed the completion of this order. Now, you can leave a review to the seller. :)"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer_order
      @customer_order = CustomerOrder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_order_params
      params.require(:customer_order).permit(:name, :address_one, :address_two, :city, :state, :zipcode, :country, :email, :remarks, :gig_id, :buyer_id, :seller_id, :payment_status, :notification_params, :status, :transaction_id, :purchased_at)
    end
end
