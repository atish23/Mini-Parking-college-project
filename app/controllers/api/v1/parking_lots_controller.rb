module Api::V1
class ParkingLotsController < ApplicationController
  respond_to :json


  # def parking_status
  #   lots=ParkingLot.select("id,slot_id").where("parking_id=? AND availaible=?",params[:id],true)
  #   respond_with lots
  # end

  def update
    current_user = User.find(params[:user_id]);
    transaction=current_user.transactions.where(:current_transaction => true).first
    if transaction.nil?
        id= params[:id]
        @parking_lot=ParkingLot.find(id);
        if @parking_lot.update!(:availaible => false)
            datetime=Time.now
            date= datetime
            in_time = datetime
            parking_id = @parking_lot.parking_id
            payment_type =false
            out=datetime
            payment=0

            current_user.transactions.create!(in:in_time,out:out,payment:payment,date:date,payment_type:payment_type,parking_lot_id:id,parking_id:parking_id,current_transaction:true,currently_in:false)
            parking=Parking.find_by(id: parking_id)
            parking.update(filled:parking.filled+1)
            msg = { :status => "ok", :message => "You have successfully booked your spot.Your parking slot number is #{@parking_lot.slot_id}. Your entry time has started now." }
            respond_with msg
        else
            msg = { :status => "fail", :message => "Not Updated" }
            respond_with msg
        end
    else
        msg = { :status => "fail", :message => "You already have an Active Transaction"}
        respond_with msg
    end              
  end
end
end
