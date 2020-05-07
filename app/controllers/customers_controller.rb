class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.all
    @test = Customer.where(user_id: session[:user_id]).paginate(:page => params[:page], :per_page => 25)
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    @alljobs = Job.joins(:customer).includes(:user).where(user: session[:user_id]).order('jobs.created_at DESC')
    @customerjobs = @alljobs.all.where("customers.customer_code LIKE ?", @customer.customer_code)
    @results = @customerjobs.paginate(:page => params[:page], :per_page => 25)
    @totalJobs = @customerjobs.count
    @groupJobs = Job.joins(:customer).includes(:user).where(user: session[:user_id]).where("customers.customer_code LIKE ?", @customer.customer_code)
    @monthGroup = @groupJobs.group("strftime('%m',jobs.created_at)").count
    @monthNames = Date::MONTHNAMES
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def customer_params
      params.require(:customer).permit(:customer_code, :company_name, :address1, :address2, :address3, :eircode, :user_id)
    end
end
