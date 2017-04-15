require 'test_helper'

class BrowseControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get browse_index_url
    assert_response :success
  end

end
