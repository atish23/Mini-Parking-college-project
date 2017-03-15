class Api::V1::SessionsController < ApplicationController
	skip_before_action :verify_authenticity_token
	def create
		user = User.find_by(email: params[:email].downcase)
		# byebug
	    if user && user.authenticate(params[:password])
	      if user.activated?
	        log_in user
	         message  = "Logged in successfully"
			 response = {status: "success", msg: message, user: user}
	          respond_to do |format|
      			format.json { render json: response }
    		  end
	      else
	        response = {status: "fail", msg: "hello"}
	        respond_to do |format|
      			format.json { render json: @parkings }
    		end
	      end
	    else
	      response = {status: "fail", msg: "Check You Password!"}
	      respond_to do |format|
      		format.json { render json: response }
    	  end
	    end
	end
end
