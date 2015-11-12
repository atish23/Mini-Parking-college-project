module Api::V1
class ParkingLotsController < ApplicationController
  respond_to :json


  def parking_status
    lots=ParkingLot.select("id,slot_id").where("parking_id=? AND availaible=?",params[:id],true)
    respond_with lots
  end
  def entry
    #User id , parking id, parking_lot_id
    id=params[:ids]
    user=User.find(id[0])
    parking=Parking.find(id[1])
    parking_lot=parking.parking_lots.find(id[2])

    if parking_lot.update!(:availaible => false)
        datetime=Time.now
        date = datetime
        in_time = datetime
        Rails.logger.debug("Time now time: #{datetime.inspect}")

        parking_id = parking.id
        payment_type =false
        out=datetime
        user.transactions.create!(in:in_time,out:out,date:date,payment_type:payment_type,parking_lot_id:parking_lot.id,parking_id:parking_id,current_transaction:true,currently_in:true)
        parking=Parking.find_by(id: parking_id)
        parking.update(filled:parking.filled+1)
        respond_with "Success"
    else
        respond_with "Error"
    end
  end



end
end
