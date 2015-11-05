class ParkingLotsController < ApplicationController



  def update
    id=params[:id]
    @parking_lot=ParkingLot.find(id)
    # debugger
    if @parking_lot.update!(:availaible => false)
        flash[:info] = "You have successfully booked your spot.Your parking slot number is #{@parking_lot.slot_id+1}. Your entry time has started now."
        datetime=Time.now
        date= datetime
        in_time = datetime
        Rails.logger.debug("Time now time: #{datetime.inspect}")

        parking_id = @parking_lot.parking_id
        payment_type =false
        out=datetime
        payment=0

        current_user.transactions.create!(in:in_time,out:out,payment:payment,date:date,payment_type:payment_type,parking_lot_id:id,parking_id:parking_id,current_transaction:true,currently_in:true)
        parking=Parking.find_by(id: parking_id)
        parking.update(filled:parking.filled+1)
        redirect_to request.referrer
    else
      flash[:info] = "Not updated!"
      redirect_back
    end
  end


end
