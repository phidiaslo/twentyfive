class CashoutsController < ApplicationController
  before_action :set_cashout, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  before_filter :verify_admin, only: [:index, :edit, :update, :destroy]


  # GET /cashouts
  # GET /cashouts.json
  def user_cashout
    @cashouts = Cashout.where(user: current_user).page(params[:page]).per(20)
    @pendings = CustomerOrder.where(seller: current_user, status: 'Pending', payment_status: 'Paid')
  end

  def index
    @cashouts = Cashout.all.includes(:user).page(params[:page]).per(20)
  end

  # GET /cashouts/1
  # GET /cashouts/1.json
  def show
  end

  # GET /cashouts/new
  def new
    @cashout = Cashout.new
  end

  # GET /cashouts/1/edit
  def edit
  end

  # POST /cashouts
  # POST /cashouts.json
  def create
    @cashout = Cashout.new(cashout_params)
      if @cashout.amount <= current_user.balance
        @cashout.user_id = current_user.id
        @cashout.status = 'In Progress'
        respond_to do |format|
          if @cashout.save
            format.html { redirect_to @cashout, notice: 'Cashout was successfully created.' }
            format.json { render :show, status: :created, location: @cashout }
          else
            format.html { render :new }
            format.json { render json: @cashout.errors, status: :unprocessable_entity }
          end
        end
      else
        redirect_to new_cashout_url, notice: "Sorry, but you can't withdraw that much!"
      end
    end

  # PATCH/PUT /cashouts/1
  # PATCH/PUT /cashouts/1.json
  def update
    respond_to do |format|
      if @cashout.update(cashout_params)
        format.html { redirect_to cashouts_url, notice: 'Cashout was successfully updated.' }
        format.json { render :show, status: :ok, location: @cashout }
      else
        format.html { render :edit }
        format.json { render json: @cashout.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cashouts/1
  # DELETE /cashouts/1.json
  def destroy
    @cashout.destroy
    respond_to do |format|
      format.html { redirect_to cashouts_url, notice: 'Cashout was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def edit_cashouts
    @cashouts = Cashout.find(params[:cashout_ids])

    if params[:commit] == 'Delete'
      @cashouts.each { |cashout|
        Cashout.destroy(cashout.id)  }
    elsif params[:commit] == 'In Progress'
      @cashouts.each { |cashout|
        cashout.status = 'In Progress'
        cashout.save 
      }
    else params[:commit] == 'Transferred'
        @cashouts.each { |cashout|
          cashout.status = 'Transferred'
          cashout.save
          user = User.find(cashout.user)
          user.decrement!(:balance, cashout.amount) 
        }
    end
    redirect_to :back, notice: 'All statuses has baeen successfully updated.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cashout
      @cashout = Cashout.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cashout_params
      params.require(:cashout).permit(:amount, :status, :user_id)
    end

    def verify_admin
      if current_user.role != 'Admin'
        redirect_to root_url, alert: "Sorry, but you're not allowed access to this page."
      end
    end

end
