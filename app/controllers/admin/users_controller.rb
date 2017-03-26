module Admin
  class UsersController < ApplicationController
    load_and_authorize_resource

    def index
      @users = User.paginate(:page => params[:page], :per_page => 10)
    end

    def manage_categories
      @categories = Category.includes(:subcategories).paginate(:page => params[:page], :per_page => 10)
    end

    def manage_products
      @products = Product.paginate(:page => params[:page], :per_page => 5)
    end

    def manage_orders
      @orders = Order.paginate(:page => params[:page], :per_page => 10)
    end

    def change_role
      @user = User.find(params[:id])

      if @user.has_role? :user
        assign_new_role(:user, :admin)
      else
        assign_new_role(:admin, :user)
      end

      redirect_to admin_users_path, :notice => 'Role changed!'
    end

    def block
      @user = User.find(params[:id])

      if @user.active?
        @user.deleted!
      else
        @user.active!
      end

      redirect_to admin_users_path, :notice => 'Status changed!'

    end

    def dashboard
      @total_categories = Category.includes(:subcategories).count
      @total_products = Product.count
      @total_users = User.count
      @total_orders = Order.count
    end

    private

    def assign_new_role(old_role, new_role)
      @user.remove_role old_role
      @user.add_role new_role
    end

  end
end