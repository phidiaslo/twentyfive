class SubcategoriesController < ApplicationController
  before_action :set_subcategory, only: [:show, :edit, :update, :destroy]

  #respond_to :html

  def index
    @subcategories = Subcategory.all.includes(:category)
  end

  def show
    @gigs = Gig.where(subcategory_id: @subcategory).order('view_count DESC')
    @gigs = @search.result(distinct: true).page(params[:page]).per(1).includes(:user)
    @images = Image.all.order('created_at DESC')
  end

  def new
    @subcategory = Subcategory.new
  end

  def edit
  end

  def create
    @subcategory = Subcategory.new(subcategory_params)
    respond_to do |format|
              if @subcategory.save
                format.html { redirect_to subcategories_path, notice: 'Subcategory was successfully created.' }
                format.json { render :show, status: :created, location: @subcategory }
              else
                format.html { render :new }
                format.json { render json: @subcategory.errors, status: :unprocessable_entity }
              end
            end
  end

  def update
    respond_to do |format|
          if @subcategory.update(subcategory_params)
            format.html { redirect_to subcategories_path, notice: 'Subcategory was successfully updated.' }
            format.json { render :show, status: :ok, location: @subcategory }
          else
            format.html { render :edit }
            format.json { render json: @category.errors, status: :unprocessable_entity }
          end
        end
  end

  def destroy
    @subcategory.destroy
    respond_to do |format|
          format.html { redirect_to subcategories_url, notice: 'Category was successfully destroyed.' }
          format.json { head :no_content }
        end
  end

  private
    def set_subcategory
      @subcategory = Subcategory.friendly.find(params[:id])
    end

    def subcategory_params
      params.require(:subcategory).permit(:name, :category_id, :slug)
    end
end
