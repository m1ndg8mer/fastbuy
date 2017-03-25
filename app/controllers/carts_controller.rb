class CartsController < ApplicationController

  def index
  end

  def new
    @cart = Cart.new
  end

end
