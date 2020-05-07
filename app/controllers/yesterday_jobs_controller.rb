class YesterdayJobsController < ApplicationController
def index
	@today = Date.today
	@end = @today - 1
	@yesterdayrange = @end..@today


	@jobs = Job.joins(:customer).includes(:user).where(user: session[:user_id])

	@yesterdayJobs = @jobs.all.where("jobs.created_at" => @yesterdayrange).paginate(:page => params[:page], :per_page => 20)
	@yesterdayCount = @yesterdayJobs.count
	@yesterdayparcels = @yesterdayJobs.sum(:parcels)
	@yesterdaypallets = @yesterdayJobs.sum(:pallets)
	@yesterdaybundles = @yesterdayJobs.sum(:bundles)

end
end
