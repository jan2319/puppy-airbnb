class PuppiesController < ApplicationController
  before_action :set_puppy, only: [:show]

  def index
    @body_class = "need-padding"
    @puppies = Puppy.all
  end

  def show
    @booking = Booking.new
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def puppy_params
    params.require(:puppy).permit(:name, :photo_url, :description, :street, :zipcode, :city, :country, :daily_price, :birthdate, :toilet_training_level, :breed_id, :title)
  end

  def set_puppy
    @puppy = Puppy.find(params[:id])
  end
end
