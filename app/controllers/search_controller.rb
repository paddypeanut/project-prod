class SearchController < ApplicationController

	def index

	end

	def search
		@join = Job.joins(:customer).includes(:user).where(user: session[:user_id]).order('jobs.created_at DESC').paginate(:page => params[:page], :per_page => 25)

		if params[:search].blank? 
			redirect_to search_jobs_path
		
		
		else 
			
			@parameter = params[:search]

			@results = @join.all.where("jobs.customer_code LIKE ? OR customers.company_name LIKE ? OR jobs.reference LIKE ?", "%#{@parameter}%","%#{@parameter}%","%#{@parameter}%")
			@resultsCount = @results.count

		end

	end

	def search_range
	
	end

	def search_range_results
		@join = Job.joins(:customer).includes(:user).where(user: session[:user_id]).order('jobs.created_at DESC').paginate(:page => params[:page], :per_page => 25)
		
		if params[:startdate].blank? && params[:enddate].blank?
			@start = Date.today
			@enddate = Date.today

		else
		@start = Date.parse(params[:startdate])
		@enddate = Date.parse(params[:enddate]) + 1.day 
		@timerange = @start..@enddate

		#@results = @join.all.where(created_at: @start..@enddate)
		@results = @join.all.where('jobs.created_at' => @timerange)

		
		end
		@totaljobs = @results.count

	end

end
