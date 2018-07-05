class PuppiesController < ApplicationController
  before_action :set_puppy, only: [:show, :update, :destroy]
  before_action :set_puppy_for_edit, only: [:edit]
  skip_before_action :authenticate_user!, only: [:show, :index]

  def index

    if !params[:city].nil? && !params[:city].empty?
      @puppies = Puppy.where("city LIKE ?", "%#{params[:city].capitalize}%")
      @no_search_results = false
    else
      @puppies = Puppy.all
    end
    @body_class = "extra-padding"

  end

  def show
    @booking = Booking.new
    @reviews = Review.where("puppy_id = ?", params[:id])
  end

  def new
    @puppy = Puppy.new
  end

  def create
    # price_in_cents = puppy_params[:daily_price].to_f.round(2) * 100
    # puppy_params[:daily_price] = price_in_cents.to_i.to_s
    @puppy = Puppy.new(puppy_params)
    @puppy.user = current_user
    if @puppy.save
      redirect_to puppy_path(@puppy)
    else
      render :new
    end
  end

  def edit
    # User that clicks has to be user that created puppy
    if @puppy.user.id == current_user.id

    else
      redirect_to puppy_path(@puppy)
    end
  end

  def update
    if @puppy.user.id == current_user.id
      @puppy.update(puppy_params)
      redirect_to puppy_path(@puppy)
    else
      redirect_to puppy_path(@puppy)
    end
  end

  def destroy
    if @puppy.user.id == current_user.id
      @puppy.destroy
      redirect_to puppies_path
    else
      redirect_to puppy_path(@puppy)
    end
  end

  private

  def puppy_params
    price_in_cents = params[:puppy][:daily_price].to_f.round(2) * 100
    params[:puppy][:daily_price] = price_in_cents.to_i
    params.require(:puppy).permit(:name, :photo_url, :description, :street, :zipcode, :city, :country, :daily_price, :birthdate, :toilet_training_level, :breed_id, :title)
  end

  def set_puppy
    @puppy = Puppy.find(params[:id])
  end

  def set_puppy_for_edit
    @puppy = Puppy.find(params[:id])
    @puppy.daily_price = @puppy.daily_price.to_f / 100
    @puppy
  end
end
