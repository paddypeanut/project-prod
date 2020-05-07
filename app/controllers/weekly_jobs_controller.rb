class WeeklyJobsController < ApplicationController
	def index
	@today = Date.today
	@weekstart = @today.beginning_of_week
	@weekrange = @weekstart..(@today + 1)
	
	@jobs = Job.joins(:customer).includes(:user).where(user: session[:user_id])

	@weekJobs = @jobs.all.where("jobs.created_at" => @weekrange)
	@weekCount = @weekJobs.count
	@weekparcels = @weekJobs.sum(:parcels)
	@weekpallets = @weekJobs.sum(:pallets)
	@weekbundles = @weekJobs.sum(:bundles)
	@weekByDay = @weekJobs.group("DATE(jobs.created_at)").count
	@weekParcelsByday = @weekJobs.group("DATE(jobs.created_at)").pluck(:created_at , 'count(jobs.created_at)','sum(jobs.parcels)' , 'sum(jobs.pallets)' , 'sum(jobs.bundles)')
	@results = @weekJobs.paginate(:page => params[:page], :per_page => 25)
	end
end
