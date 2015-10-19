class ParkingsController < ApplicationController
  before_action :valid_user, only: [:edit, :update]

  def index
    @parkings=Parking.all

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @parkings }
    end
  end

  def edit
  end

  def update
  end

  def show
    @parking=Parking.find(params[:id])
    @parkinglots=@parking.parking_lots
  end


  private
  # Confirms a valid user.
  def valid_user
    unless (@user && @user.activated? &&
            @user.authenticated?(:reset, params[:id]))
      redirect_to root_url
    end
  end


end
