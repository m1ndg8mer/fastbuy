class ReviewsController < ApplicationController
  load_and_authorize_resource
  before_action :initialize_product, only: [:create, :destroy]

  def create
    @review = current_user.reviews.new(review_params)
    @review[:product_id] = @product.id

    if @review.save
      redirect_to @product
    end

  end

  def destroy
    Review.find(params[:id]).destroy

    redirect_to @product
  end

  private

  def review_params
    params.require(:review).permit(:review, :rating)
  end

  def initialize_product
    @product = Product.find(params[:product_id])
  end

end
