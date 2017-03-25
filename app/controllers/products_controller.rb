class ProductsController < ApplicationController
  load_and_authorize_resource

  before_action :set_cart
  before_action :initialize_product, except: [:new, :create]
  before_action :initialize_categories

  def new
    if Category.sub.length == 0
      redirect_to manage_products_admin_users_path, :alert => 'First create subcategory!'
    end
    @product = Product.new
  end

  def show
    @similar_products = Product.similar(@product.category_id)
    @reviews = @product.reviews.paginate(:page => params[:page], :per_page => 5)
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
    @parents_categories = Category.all.reject { |c| c.parent_id }
    @parents_categories = @parents_categories.first(9)
  end

  def set_cart
    @cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    @cart = cart
  end

end
