class SessionsController < ApplicationController
skip_before_action :authorized, only: [:new, :create, :welcome]

def home
	@today = Date.today
	@end = @today - 1
	@yesterdayrange = @end..@today

	@weekstart = @today.beginning_of_week
	@monthstart = @today.beginning_of_month
	@lastmonth = @monthstart - 1.month
	@monthrange = @monthstart..@today + 1
	@weekrange = @weekstart..(@today + 1)
	
	@jobs = Job.joins(:customer).includes(:user).where(user: session[:user_id])
	@todayJobs = @jobs.all.where("jobs.created_at >= ?", @today)
	@todayCount = @todayJobs.count
	@todayparcels = @todayJobs.sum(:parcels)
	@todaypallets = @todayJobs.sum(:pallets)
	@todaybundles = @todayJobs.sum(:bundles)

	@yesterdayJobs = @jobs.all.where("jobs.created_at" => @yesterdayrange)
	@yesterdayCount = @yesterdayJobs.count
	@yesterdayparcels = @yesterdayJobs.sum(:parcels)
	@yesterdaypallets = @yesterdayJobs.sum(:pallets)
	@yesterdaybundles = @yesterdayJobs.sum(:bundles)

	@weekJobs = @jobs.all.where("jobs.created_at" => @weekrange)
	@weekCount = @weekJobs.count
	@weekparcels = @weekJobs.sum(:parcels)
	@weekpallets = @weekJobs.sum(:pallets)
	@weekbundles = @weekJobs.sum(:bundles)
	@weekByDay = @weekJobs.group("DATE(jobs.created_at)").count
	@weekParcelsByday = @weekJobs.group("DATE(jobs.created_at)").pluck(:created_at ,'count(jobs.created_at)','sum(jobs.parcels)' , 'sum(jobs.pallets)' , 'sum(jobs.bundles)')
	
	@monthJobs = @jobs.all.where("jobs.created_at" => @monthrange)
	@monthCount = @monthJobs.count
	@monthparcels = @monthJobs.sum(:parcels)
	@monthpallets = @monthJobs.sum(:pallets)
	@monthbundles = @monthJobs.sum(:bundles)
	@monthByDay = @monthJobs.group("DATE(jobs.created_at)").count
	@monthEachDay = @monthJobs.group("DATE(jobs.created_at)").pluck(:created_at , 'count(jobs.created_at)', 'sum(jobs.parcels)', 'sum(jobs.pallets)','sum(jobs.bundles)')
end

def new
end
def login
end
def create
   @user = User.find_by(username: params[:username])
   if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to '/home'
   else
      redirect_to '/welcome' 
   end
end
def page_requires_login
end

def destroy
	log_out
	redirect_to welcome_path
end

end