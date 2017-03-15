module Api::V1
class ParkingsController < ApplicationController

  def index
    @parkings=Parking.all
    respond_to do |format|
      format.json { render json: @parkings }
    end
  end

  def show
    @parking=Parking.find(params[:id])
    @parkinglots=@parking.parking_lots
    respond_to do |format
      format.json { render json: @parkinglots }
    end
  end
end
end
