require 'test_helper'

class DailyJobsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get daily_jobs_index_url
    assert_response :success
  end

end
