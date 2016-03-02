class ReviewsController < ApplicationController

  def restaurant_owner
    @restaurant = Restaurant.find(params[:id])
    unless @restaurant.user_id == current_user.id
      flash[:notice] = 'You are not authorised to change the restaurant'
      redirect_to restaurants_path
    end
  end

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @restaurant.reviews.create(review_params)

    redirect_to restaurants_path
  end

  def review_params
    params.require(:review).permit(:thoughts, :rating, :user_id)
  end
end
