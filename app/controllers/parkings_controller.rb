class ParkingsController < ApplicationController
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
  end
end
