require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
	test "should redirect to logon if not logged in" do
		get :edit, :id => '0'
		assert_redirected_to new_user_session_path
	end
	
	test "should error if no id provided" do
		sign_in users(:joe)
		get :edit
		assert_response :error
	end
	
  test 'edit user' do
    u = users(:joe)
    sign_in u
	 get :edit, :id => u.id
    assert_response :success
  end
    
end
