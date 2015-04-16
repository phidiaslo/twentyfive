class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:index, :new, :edit, :create, :update, :destroy]
  before_filter :verify_admin, only: [:index, :new, :edit, :create, :update, :destroy]

  #respond_to :html

  def index
    @categories = Category.all
    #respond_with(@categories)
  end

  def show
    #respond_with(@category)
  end

  def new
    @category = Category.new
    #respond_with(@category)
  end

  def edit
  end

  def create
    @category = Category.new(category_params)

    respond_to do |format|
          if @category.save
            format.html { redirect_to categories_path, notice: 'Category was successfully created.' }
            format.json { render :show, status: :created, location: @category }
          else
            format.html { render :new }
            format.json { render json: @category.errors, status: :unprocessable_entity }
          end
        end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to categories_path, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category.destroy
    
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name)
    end

    def verify_admin
      if current_user.role != 'Admin'
        redirect_to root_url, alert: "Sorry, but you're not allowed access to this page."
      end
    end
end


  