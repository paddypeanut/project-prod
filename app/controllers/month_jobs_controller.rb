class MonthJobsController < ApplicationController
	def index
	@today = Date.today
	

	
	@monthstart = @today.beginning_of_month
	@lastmonth = @monthstart - 1.month
	@monthrange = @monthstart..@today + 1


	@jobs = Job.joins(:customer).includes(:user).where(user: session[:user_id])

	@monthJobs = @jobs.all.where("jobs.created_at" => @monthrange)
	@monthCount = @monthJobs.count
	@monthparcels = @monthJobs.sum(:parcels)
	@monthpallets = @monthJobs.sum(:pallets)
	@monthbundles = @monthJobs.sum(:bundles)
	@monthByDay = @monthJobs.group("DATE(jobs.created_at)").count
	@monthEachDay = @monthJobs.group("DATE(jobs.created_at)").pluck(:created_at ,'count(jobs.created_at)','sum(jobs.parcels)', 'sum(jobs.pallets)','sum(jobs.bundles)')
	@results = @monthJobs.paginate(:page => params[:page], :per_page => 25)

	end

	def monthly
		

		@monthParam = params[:jobMonth]
		

		
		@jobs = Job.joins(:customer).includes(:user).where(user: session[:user_id])
		@months = Date::MONTHNAMES
		@monthNum = @monthParam.strip.last(2).to_f
		@year = @monthParam.strip.first(4)
		@monthName = @months[@monthNum]

		@jobsThisMonth = @jobs.all.where('jobs.created_at LIKE ?',"%#{@monthParam}%")
		@monthCount = @jobsThisMonth.count
		@monthparcels = @jobsThisMonth.sum(:parcels)
		@monthpallets = @jobsThisMonth.sum(:pallets)
		@monthbundles = @jobsThisMonth.sum(:bundles)
		@monthByDay = @jobsThisMonth.group("DATE(jobs.created_at)").count
		@monthEachDay = @jobsThisMonth.group("DATE(jobs.created_at)").pluck(:created_at , 'count(jobs.created_at)', 'sum(jobs.parcels)', 'sum(jobs.pallets)','sum(jobs.bundles)')
		@results = @jobsThisMonth.paginate(:page => params[:page], :per_page => 25)
	end
end
