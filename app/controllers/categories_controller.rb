class CategoriesController < ApplicationController
  load_and_authorize_resource
  before_action :initialize_category, except: [:index, :new, :create]
  before_action :load_parent_categories

  def index
    @categories = Category.includes(:subcategories).paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @category = Category.new
  end

  def show
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to categories_path, :notice => 'Success!'
    else
      render :new
    end
  end

  def update
    if @category.update_attributes(category_params)
      redirect_to @category, :notice => 'Success!'
    else
      render :edit
    end
  end

  def edit
  end

  def destroy
    @category.products.each(&:destroy!)
    @category.destroy

    redirect_to categories_path, :notice => 'Success!'
  end

  private

  def category_params
    params.require(:category).permit(:title, :parent_id)
  end

  def initialize_category
    @category = Category.find(params[:id])
  end

  def load_parent_categories
    @parents = Category.all.reject { |c| c.parent_id }
  end

end
