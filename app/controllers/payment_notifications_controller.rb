class PaymentNotificationsController < ApplicationController
  before_action :set_payment_notification, only: [:show, :edit, :update, :destroy]
  protect_from_forgery :except => [:create]
  respond_to :html

  def index
    @payment_notifications = PaymentNotification.all
    respond_with(@payment_notifications)
  end

  def show
    respond_with(@payment_notification)
  end

  def new
    @payment_notification = PaymentNotification.new
    respond_with(@payment_notification)
  end

  def edit
  end

  def create
    PaymentNotification.create!(:params => params, :order_id => params[:invoice], :status => params[:payment_status], :transaction_id => params[:txn_id])
    render :nothing => true
  end

  def update
    @payment_notification.update(payment_notification_params)
    respond_with(@payment_notification)
  end

  def destroy
    @payment_notification.destroy
    respond_with(@payment_notification)
  end

  private
    def set_payment_notification
      @payment_notification = PaymentNotification.find(params[:id])
    end

    def payment_notification_params
      params.require(:payment_notification).permit(:params, :order_id, :status, :transaction_id, :create)
    end
end
