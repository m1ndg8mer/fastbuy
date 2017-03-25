class LineItemsController < ApplicationController
  before_action :set_line_item, only: [:update, :destroy]

  def new
    @line_item = LineItem.new
  end

  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product.id)

    respond_to do |format|
      if @line_item.save
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @line_item.update_attributes(line_item_params)
        format.js
      end
    end
  end

  def destroy
    @line_item.destroy
    respond_to do |format|
      format.js
    end
  end

  private
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    def line_item_params
      params.require(:line_item).permit(:quantity)
    end
end
