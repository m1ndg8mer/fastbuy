class ProductsController < ApplicationController
  load_and_authorize_resource
  before_action :initialize_product, except: [:index, :new, :create]
  before_action :initialize_categories

  def index
    @products = Product.all.paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @product = Product.new
  end

  def show
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to manage_products_admin_users_path, :notice => 'Success!'
    else
      render :new
    end
  end

  def update
    if @product.update_attributes(product_params)
      redirect_to edit_product_path(@product), :notice => 'Success!'
    else
      render :edit
    end
  end

  def edit
  end

  def destroy
    @product.destroy

    redirect_to manage_products_admin_users_path, :notice => 'Success!'
  end

  private

  def product_params
    params.require(:product).permit(:title, :qty, :price, :img, :description, :category_id)
  end

  def initialize_product
    @product = Product.find(params[:id])
  end

  def initialize_categories
    @categories = Category.sub
  end

end
