class ReviewsController < ApplicationController
  before_action :set_booking, only: [:show, :new, :create]

  def new
    @review = Review.new
  end

  def create

    @review = Review.new(review_params)
    @puppy = @booking.puppy
    @review.puppy = @puppy
    @review.booking = @booking
    @review.user = current_user

    if @review.save
      redirect_to bookings_path
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
