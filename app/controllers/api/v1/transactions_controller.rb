module Api::V1
class TransactionsController < ApplicationController
  respond_to :json

def  booked_online
    transaction=Transaction.where("user_id=? AND current_transaction=?",params[:id],true).first
    if transaction.nil?
      respond_with "false"
    else

      transaction.update!(currently_in:true)
      respond_with "true"
    end
end

def exit
  transaction=Transaction.where("user_id=? AND current_transaction=?",params[:id],true).first
  time_taken=(((Time.now).to_time - transaction.in)/1.hour).round
  Rails.logger.debug("Time now time: #{Time.now.inspect}")
  Rails.logger.debug("My  transaction: #{transaction.in}")
  Rails.logger.debug("My time: #{time_taken}")
  if(time_taken==0)
    time_taken=time_taken+1
  end
  out=Time.now.to_time
  parking=Parking.find_by(id: transaction.parking_id)
  parking_lot=ParkingLot.find_by(id: transaction.parking_lot_id)
  Rails.logger.debug { "#{transaction.id}" }
  cost=time_taken*parking.cost
  Rails.logger.debug("My time: #{cost.inspect}")
  transaction.update!(current_transaction:false,payment:cost,out:out)
  parking.update(filled:parking.filled-1)
  parking_lot.update(availaible:true)

  #flash[:success] = "Transaction ended! Your total cost is Rs.#{cost}"
  respond_with cost
end


end
end
