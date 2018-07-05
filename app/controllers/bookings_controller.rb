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
    # Store dates from params as actual dates and not string
    @start_date = DateTime.parse(booking_params["start_date"])
    @end_date = DateTime.parse(booking_params["end_date"])

    @string = check_dates(@start_date, @end_date, @puppy)

    if @string == "true"
      @booking = Booking.new(booking_params)
      @booking.puppy = @puppy
      @booking.user_id = current_user.id

      # Calculate Total Price depending on selected time period
      total_price = (@end_date - @start_date)  / 60 / 60 / 24 * @puppy.daily_price
      @booking.total_price = total_price

      if @booking.save
        redirect_to puppy_booking_path(@puppy, @booking)
      else
        redirect_to puppy_path(@puppy)
      end
    else
      redirect_to puppy_path(@puppy), notice: @string
    end
  end

  private

  def check_dates(start_date, end_date, puppy)
    today = Date.today

    # Check whether date is in future
    # Check whether end_date is after start_date
    if end_date - start_date < 0
      @string = "Please pick an end date after the start date"
    elsif (start_date - today).to_i < 0
      @string = "Please pick a start date in the future"
    elsif (end_date - today).to_i < 0
      @string = "Please pick a start date in the future"
    else
      # Check whether Puppy available
      if check_puppy_available(start_date, end_date, puppy)
        @string = "true"
      else
        @string = "Sorry, Puppy #{puppy.name} is already booked for the selected time period."
      end
    end
    return @string
  end

  def check_puppy_available(start_date, end_date, puppy)
    # Make sure only to check for bookings that are CONFIRMED
    @all_bookings = puppy.bookings.where("confirmed = ? ", true)
    # If there are no confirmed bookings, puppy is available
    if @all_bookings.empty?
      @value = true
    else
      # If there are confirmed bookings, check whether dates overlap
      @all_bookings.each do |booking|
        @value = booking.start_date <= end_date && booking.end_date <= start_date
      end
    end
    return @value
  end

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

