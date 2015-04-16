class ImagesController < ApplicationController
  before_action :set_image, only: [:edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:index, :edit, :destroy]
  before_filter :verify_admin, only: [:index, :edit, :destroy]

  def index
    @images = Image.all.order('created_at DESC').includes(:gig).page(params[:page]).per(10)
  end

  def new
    @image = Image.new
  end

  def edit
  end

  def create
    @image = Image.new(image_params)

    respond_to do |format|
          if @image.save
            format.html { redirect_to images_path, notice: 'Image was successfully uploaded.' }
            format.json { render :show, status: :created, location: @image }
          else
            format.html { render :new }
            format.json { render json: @image.errors, status: :unprocessable_entity }
          end
        end
  end

  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to images_path, notice: 'Image was successfully updated.' }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to images_url, notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_image
      @image = Image.find(params[:id])
    end

    def image_params
      params.require(:image).permit(:gig_id, :graphic)
    end

    def verify_admin
      if current_user.role != 'Admin'
        redirect_to root_url, alert: "Sorry, but you're not allowed access to this page."
      end
    end
end
