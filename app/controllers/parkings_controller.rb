class ParkingsController < ApplicationController
  def index
    @parkings=Parking.all
  end

  def edit
  end

  def update
  end

  def show
  end
end
