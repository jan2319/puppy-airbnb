class PuppiesController < ApplicationController
  before_action :set_puppy, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:show, :index]

  def index
    if !params[:city].nil? && !params[:city].empty?
      @puppies = Puppy.where("city = ?", params[:city])
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
    @puppy = Puppy.new
  end

  def create
    @puppy = Puppy.new(puppy_params)
    @puppy.user = current_user
    if @puppy.save
      redirect_to puppy_path(@puppy)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @puppy.update(puppy_params)
    redirect_to puppy_path(@puppy)
  end

  def destroy
    @puppy.destroy
    redirect_to puppies_path
  end

  private

  def puppy_params
    params.require(:puppy).permit(:name, :photo_url, :description, :street, :zipcode, :city, :country, :daily_price, :birthdate, :toilet_training_level, :breed_id, :title)
  end

  def set_puppy
    @puppy = Puppy.find(params[:id])
  end
end
