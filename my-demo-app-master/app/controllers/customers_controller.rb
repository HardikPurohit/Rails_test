class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update]

  # GET /customers
  # GET /customers.json
  def index
    if current_admin.nil?
      @bookings = Booking.where(customer_id: session[:customer_id])
    else
      @customers = Customer.all
    end
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
  end

  # GET /customers/new
  def new
    if current_admin.nil?
      @customer = Customer.new
    else
      redirect_to admins_path
    end
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  # POST /customers.json
  def create
    if params[:commit] == "Log in"
      @login_customer = Customer.where(phone_number: params[:customer][:phone_number], password: params[:customer][:password])
      if @login_customer.count == 1
        session[:customer_id] = @login_customer.first.id
        redirect_to action: "index"
      else
        flash[:invalid_customer] = "Invalid Phone Number or Password"
        redirect_to action: "new"
      end
    elsif params[:commit] == "Sign up"
      @customer = Customer.new(customer_params)
      if Customer.where(:phone_number => customer_params[:phone_number]).blank?
        if @customer.save
          session[:customer_id] = @customer.id
          redirect_to action: "index"
        else
          render :new
        end
      else
        session[:customer_id] = Customer.find_by(phone_number: customer_params[:phone_number]).id
        redirect_to action: "index"
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    #destroy session of customer
    session[:customer_id] = nil
    redirect_to root_path
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
      @customer_booking = Booking.where(customer_id: params[:id]).includes(:cleaner,:city)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
end
