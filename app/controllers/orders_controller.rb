class OrdersController < ApplicationController
  load_and_authorize_resource

  def index
    @orders = current_user.orders.paginate(:page => params[:page], :per_page => 5)
  end

  def new
    @order = Order.new
  end

  def create
    @order = current_user.orders.new
    @order.cart = @cart

    @cart = Cart.create
    session[:cart_id] = @cart.id

    if @order.save
      redirect_to root_path, :notice => 'Success! Out manager will call to you soon!'
    else
      render :new
    end
  end

  def change_status
    order = Order.find(params[:id])
    status = params[:status_id].to_i

    if order.update(status: status)
      redirect_to manage_orders_admin_users_path, :notice => 'Updated!'
    end
  end

end
