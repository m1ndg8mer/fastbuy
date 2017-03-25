module ProductsHelper
  def get_user_email_by_id(id)
    User.find(id).email
  end

  def get_avg_rating(reviews)
    return 0.0 if reviews.count == 0

    reviews.sum(:rating).to_f / reviews.count
  end
end
