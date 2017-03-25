class CategoriesController < ApplicationController
  load_and_authorize_resource
  before_action :initialize_category, except: [:new, :create]
  before_action :load_parent_categories

  def new
    @category = Category.new
  end

  def show
    @products = @category.products
  end

  def create
    @category = Category.new(category_params)

    if params[:parent]
      @category.parent_id = nil
    end

    if @category.save
      redirect_to manage_categories_admin_users_path, :notice => 'Success!'
    else
      render :new
    end
  end

  def update
    if @category.update_attributes(category_params)

      redirect_to edit_category_path(@category), :notice => 'Success!'
    else
      render :edit
    end
  end

  def edit
  end

  def destroy
    @category.destroy

    redirect_to manage_categories_admin_users_path, :notice => 'Success!'
  end

  private

  def category_params
    params.require(:category).permit(:title, :parent_id, :parent)
  end

  def initialize_category
    @category = Category.find(params[:id])
  end

  def load_parent_categories
    @parents = Category.all.reject { |c| c.parent_id }
  end

end
