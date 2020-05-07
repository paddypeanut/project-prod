class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]

  # GET /jobs
  # GET /jobs.json
  def index
    @jobs = Job.all
    
    @test = Job.joins(:customer).includes(:user).where(user: session[:user_id]).order('jobs.created_at DESC').paginate(:page => params[:page], :per_page => 20)

    @customer = Customer.all.where(user: session[:user_id])
    @monthGroup = @jobs.group("strftime('%m',jobs.created_at)").count
    
  

   


  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
  end

  # GET /jobs/new
  def new
    @job = Job.new
    @customers = Customer.joins(:user).where(user: session[:user_id])
  end

  # GET /jobs/1/edit
  def edit
    @customers = Customer.joins(:user).where(user: session[:user_id]) 
  end

  # POST /jobs
  # POST /jobs.json

  def create


    @job = Job.new(job_params)

    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: 'Job was successfully created.' }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update

    respond_to do |format|
      if @job.update(job_params)

        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def job_params
      params.require(:job).permit(:customer_code, :parcels, :pallets, :bundles, :user_id,:customer_id,:reference )
    end
end
