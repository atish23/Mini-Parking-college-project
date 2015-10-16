class ParkingLotsController < ApplicationController

  def update
    id=params[:id]

    @parking_lot=ParkingLot.find(id)
  # debugger

    if @parking_lot.update!(:availaible => false)
        flash[:info] = "You have successfully booked your spot.Your parking slot number is #{@parking_lot.slot_id+1}. Your entry time has started now."
        datetime=Time.now
        date= datetime.to_date
        in_time = datetime.to_time
        parking_id = @parking_lot.parking_id
        payment_type =false
        out=datetime.to_time
        payment=0
        current_user.transactions.create!(in:in_time,out:out,payment:payment,date:date,payment_type:payment_type,parking_id:parking_id)
        redirect_to request.referrer
    else
      flash[:info] = "Not updated!"
      redirect_back
    end
  end

end
