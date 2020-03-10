require 'test_helper'

class CorporationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get corporations_index_url
    assert_response :success
  end

  test "should get show" do
    get corporations_show_url
    assert_response :success
  end

end
