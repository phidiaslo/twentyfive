class CashoutsController < ApplicationController
  before_action :set_cashout, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  before_filter :verify_admin, only: [:index, :edit, :update, :destroy]


  # GET /cashouts
  # GET /cashouts.json
  def user_cashout
    @cashouts = Cashout.where(user: current_user).page(params[:page]).per(20)
  end

  def index
    @cashouts = Cashout.all.page(params[:page]).per(20)
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
    @cashout.user_id = current_user.id

    respond_to do |format|
      if @cashout.save
        format.html { redirect_to @cashout, notice: 'Cashout was successfully created.' }
        format.json { render :show, status: :created, location: @cashout }
      else
        format.html { render :new }
        format.json { render json: @cashout.errors, status: :unprocessable_entity }
      end
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
