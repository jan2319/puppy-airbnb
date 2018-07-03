class ReviewsController < ApplicationController
  before_action :set_booking, only: [:show, :new, :create]

  def new
    @review = Review.new
  end

  def create

    @review = Review.new(review_params)
    ### NOTE USER MUST BE REPLACED as soon as we have "users"
    @user = User.last
    @puppy = @booking.puppy
    @review.puppy = @puppy
    @review.booking = @booking
    @review.user = @user

    if @review.save
      redirect_to puppy_booking_path(@puppy, @booking)
    else
      render :new
    end
  end

  def show
  end

  private

  def review_params
    params.require(:review).permit(:title, :description, :rating)
  end

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end
end
