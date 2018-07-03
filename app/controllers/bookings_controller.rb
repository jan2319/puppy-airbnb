class BookingsController < ApplicationController
  before_action :set_booking, only: [:show]

  def new
    @booking = Booking.new
    @puppy = Puppy.find(params[:puppy_id])
  end

  def show
    @puppy = Puppy.find(params[:puppy_id])
  end

  def confirm
    @puppy = Puppy.find(params[:puppy_id])
    @booking = Booking.find(params[:booking_id])
    @booking.confirmed = true
    @booking.save
    redirect_to puppy_booking_path(@puppy, @booking)
  end

  def create
    @puppy = Puppy.find(params[:puppy_id])
    @booking = Booking.new(booking_params)
    @booking.puppy = @puppy
    @booking.user_id = 1
    @booking.total_price = params["total_price"]

    if @booking.save
      redirect_to puppy_booking_path(@puppy, @booking)
    else
      raise
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
end

