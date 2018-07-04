class PuppiesController < ApplicationController
  before_action :set_puppy, only: [:show]
  skip_before_action :authenticate_user!, only: [:show, :index]

  def index
    if !params[:city].nil? && !params[:city].empty?
      @puppies = Puppy.where("city LIKE ?", "%#{params[:city].capitalize}%")
    else
      @puppies = Puppy.all
    end
    @body_class = "need-padding"
  end

  def show
    @booking = Booking.new
    @reviews = Review.where("puppy_id = ?", params[:id])
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
