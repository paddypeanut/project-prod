class DailyJobsController < ApplicationController
  def index

  	@test = Job.joins(:customer).includes(:user).where(user: session[:user_id]).where("jobs.created_at >= ?", Time.zone.now.beginning_of_day).order('jobs.created_at DESC').paginate(:page => params[:page], :per_page => 20)
  end
end
