class UsersController < ApplicationController
  #before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only:[:edit, :update]

  require 'rqrcode_png'
  # GET /users
  # GET /users.json
  def index
    @users = User.paginate(page: params[:page],:per_page => 15)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
#    debugger we can use debugger here !
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])

  end

  # POST /users
  # POST /users.json
  def create
  @user = User.new(user_params)

  if @user.save
  str="#{@user.id}"+","+"#{@user.name}"+","+"#{@user.car_number}"
  qr = RQRCode::QRCode.new( "#{str}", :size => 6, :level => :h )
  png = qr.to_img                                             # returns an instance of ChunkyPNG
  png=png.resize(300, 300)
  @user.update_attribute :qrcode, png.to_string
  @user.send_activation_email
  flash[:info] = "Please check your email to activate your account."
  redirect_to root_url
else
  render 'new'
end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
       redirect_to @user
   else
     render 'edit'
   end

  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # allow only correct user to edit data!
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email,:password, :password_confirmation,:car_number,:mobile)
    end


end
