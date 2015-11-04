class TransactionsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def new
  end

  def edit
  end

  def index
    #@user=current_user
    @transactions=current_user.transactions.order("created_at desc")
    @active_transaction=current_user.transactions.find_by(current_transaction:true)
  #  debugger
  end

  def create
    @transaction = current_user.transactions.build(transaction_params)
    if @transaction.save
     flash[:success] = "transaction created!"
     redirect_to transactions_path
    else
     @feed_items = []
     flash[:error] = "Some error occured,please try again!"

     redirect_to transactions_path

   end
  end

  def update
    @transaction=Transaction.find(params[:id])
    time_taken=(((Time.now).to_time - @transaction.in)/1.hour).round
    Rails.logger.debug("Time now time: #{Time.now.inspect}")
    Rails.logger.debug("My  transaction: #{@transaction.in}")

    Rails.logger.debug("My time: #{time_taken}")
    if(time_taken==0)
      time_taken=time_taken+1
    end
    parking=Parking.find_by(id: @transaction.parking_id)

    cost=time_taken*parking.cost
    Rails.logger.debug("My time: #{cost.inspect}")

    @transaction.update!(current_transaction:false,payment:cost)
    parking.update(filled:parking.filled-1)
    flash[:success] = "Transaction ended! Your total cost is Rs.#{cost}"
    redirect_to request.referrer
  end
  private


    def transaction_params
      params.require(:transaction).permit(:in,:out,:payment, :payment_type)
    end

    def correct_user
      @transaction = current_user.transaction.find_by(id: params[:id])
    #  debugger
      redirect_to(root_url) if @transaction.nil?
    end

end
