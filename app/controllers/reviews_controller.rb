class ReviewsController < ApplicationController

  before_action :authenticate_user! #, :except => [:index, :show]

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.build_with_user review_params, current_user
    @review.save
    redirect_to restaurants_path
  end


  def destroy
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.find(params[:id])
    if (@review.user_id == current_user.id)
      @review.destroy
      flash[:notice] = 'Review deleted successfully'
    end
    redirect_to '/restaurants'
  end

  def review_params
    params.require(:review).permit(:thoughts, :rating, :user_id)
  end

  Review.find_by(restaurant_id: params[:restaurant_id], user_id: params[:user_id])



  # def only_one_review_checker
  #   @restaurant = Restaurant.find(params[:restaurant_id])
  #   if (@restaurant.reviews.find_by(user_id: current_user.id)) != nil
  #     flash[:notice] = 'You can only review a restaurant once'
  #     redirect_to restaurants_path and return 'stop'
  #   end
  # end
  #
  #
  # def create
  #   return if only_one_review_checker == 'stop'
  #   @restaurant = Restaurant.find(params[:restaurant_id])
  #   @restaurant.reviews.create(review_params)
  #
  #   redirect_to restaurants_path and return
  # end




end
