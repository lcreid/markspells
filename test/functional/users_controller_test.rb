require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  include Devise::TestHelpers
	
	# PARENT ASSIGN ANOTHER PARENT
	test "delgate parent should redirect to logon if not logged in" do
		get :delegate_parent, :id => '0'
		assert_redirected_to new_user_session_path
	end
	
	test "delgate parent should error if no id provided" do
		sign_in users(:juana_senior)
		get :delegate_parent
		assert_response :error
	end
	
  test 'delgate parent' do
    u = users(:juana_senior)
    sign_in u
	 get :delegate_parent, :id => u.id
    assert_response :success
		
		assert_select "form", 1 do
			assert_select "input#email", 1
			assert_select "input[type=checkbox]", 2
		end
	end

	test "create delgate parent redirects to login page" do
		params = { 
			:id => 0, 
			:user_ids => [ users(:one_mixed).id	]
		}
		post :create_delegate_parent, params
		assert_redirected_to new_user_session_path
	end
  
	test "create delgate parent errors if no email" do
		u = users(:juana_senior)
		sign_in u

		params = { 
			:id => u.id, 
			:user_ids => [ users(:one_mixed).id	]
		}
		post :create_delegate_parent, params
		assert_response :error
	end
	
	test "create delgate parent errors if no id" do
		u = users(:juana_senior)
		sign_in u

		params = { 
			:id => u.id, 
			:user_ids => [ users(:one_mixed).id	]
		}
		post :create_delegate_parent, params
		assert_response :error
	end
	
	test "create delgate parent redirects to try again if email not in db" do
		u = users(:juana_senior)
		sign_in u

		params = { 
			:id => u.id, 
			:email => "juan_junior@example.com",
			:user_ids => [ users(:one_mixed).id	]
		}
		post :create_delegate_parent, params
		assert_redirected_to delegate_parent_user_path(u)
		assert_not_nil flash[:error], "Nothing in flash"
	end
	
	test "create delgate parent" do
		u = users(:juana_senior)
		sign_in u
		
		joe = users(:joe)
		
		assert_difference "joe.children.count", 2 do
			params = { 
			:id => u.id, 
			:email => joe.email,
				:user_ids => u.children.each { |x| x.id }
			}
			post :create_delegate_parent, params
			assert_redirected_to edit_user_path(u)
		end
	end
  
# EDIT USER PROFILE
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
		
		assert_select "a[href$=#{delegate_parent_user_path(u)}]", 1
  end
    
end
