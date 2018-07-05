class BookingsController < ApplicationController
  before_action :set_booking, only: [:show]
  before_action :set_puppy, only: [:new, :show, :confirm, :create]
  skip_before_action :authenticate_user!, only: [:new]

  def index
    @bookings = Booking.where("user_id = ?", current_user.id)
    @printed = false
    @reviews = Review.where("user_id = ?", current_user.id)
  end

  def new
  end

  def show
    total_price = (@booking.end_date - @booking.start_date)  / 60 / 60 / 24 * @puppy.daily_price
    @booking.total_price = total_price
  end

  def confirm
    @booking = Booking.find(params[:booking_id])
    @booking.confirmed = true
    @booking.save
    redirect_to puppy_booking_path(@puppy, @booking)
  end

  def create
    raise
    @booking = Booking.new(booking_params)
    @booking.puppy = @puppy
    @booking.user_id = current_user.id
    @booking.total_price = params["total_price"]

    if @booking.save
      redirect_to puppy_booking_path(@puppy, @booking)
    else
      render :new
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :total_price)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def set_puppy
    @puppy = Puppy.find(params[:puppy_id])
  end
end

