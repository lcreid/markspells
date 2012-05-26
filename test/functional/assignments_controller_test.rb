require 'test_helper'

class AssignmentsControllerTest < ActionController::TestCase
	include Devise::TestHelpers
	
	test "create an assignment" do
		u = users(:juana_senior)
		sign_in u
		word_list = u.word_lists.first

		params = { 
			:word_list_id => word_list.id, 
			:assignments => { 
				'0' => {
					:assigned_to_id => users(:one_mixed).id, 
					:assigned_by_id => @controller.current_user.id
				}
			}
		}
		assert_difference "u.children_assigned_to(word_list.id, true).count", 1, "An assignment should be created" do
			post :create, params
			assert_response :success
		end
	end
  
	test "create errors if no ids" do
		u = users(:juana_senior)
		sign_in u
		word_list = u.word_lists.first

		params = { 
			#~ :word_list_id => word_list.id, 
			:assignments => { 
				:assigned_to_id => users(:one_mixed).id, 
				:assigned_by_id => '0'
			}
		}
		post :create, params
		assert_response :error
		
		params = { 
			:word_list_id => word_list.id, 
			:assignments => { 
				'0' => {
					:assigned_by_id => '0'
				}
			}
		}
		post :create, params
		assert_response :error
	end
	
	test "destroy an assignment" do
		u = users(:juana_senior)
		sign_in u
		word_list = u.word_lists.first
		
		assert_difference "u.children_assigned_to(word_list.id, true).count", -1, "An assignment should be destroyed" do
			params = { 
				:word_list_id => word_list.id, 
				:assignments => { 
					'0' => {
						:assigned_to_id => users(:one_each).id, 
						:assigned_by_id => @controller.current_user.id 
					}
				}
			}
			post :destroy, params
			assert_response :success
		end
	end
	
	test "destroy redirects to login page" do
		params = { 
			#~ :word_list_id => word_list.id, 
			:assignments => { 
				'0' => {
					:assigned_to_id => users(:one_each).id, 
					:assigned_by_id => '0'
				}
			}
		}
		post :destroy, params
		assert_redirected_to new_user_session_path
	end
  
	test "destroy errors if no ids" do
		u = users(:juana_senior)
		sign_in u
		word_list = u.word_lists.first

		params = { 
			#~ :word_list_id => word_list.id, 
			:assignments => { 
				'0' => {
					:assigned_to_id => users(:one_each).id, 
					:assigned_by_id => '0'
				}
			}
		}
		post :destroy, params
		assert_response :error
		
		params = { 
			:word_list_id => word_list.id, 
			:assignments => { 
				'0' => {
					:assigned_by_id => '0'
				}
			}
		}
		post :destroy, params
		assert_response :error
	end
  
	test "should get index" do
		u = users(:juana_senior)
		sign_in u
		get :index, :word_list_id => u.word_lists.first.id
		assert_response :success
		
		assert_select "div#assignment", 1, "Missing assignment div" do
			assert_select "ul#assigned", 1, "Missing assigned div" do
				assert_select "li", 1, "Missing assigned person"
			end
			
			assert_select "ul#unassigned", 1, "Missing unassigned div" do
				assert_select "li", 1, "Missing unassigned person" do
					assert_select ".name", 1, "Missing user name"
					assert_select ".assigned_to_id", 1, "Missing user id"
					assert_select ".word_list_id", 1, "Missing word list id"
					assert_select ".assigned_by_id", 1, "Missing assigned by id"
				end
			end
			
		end
	end
	
	test "should redirect to logon if not logged in" do
		get :index, :id => '0'
		assert_redirected_to new_user_session_path
	end
	
	test "should error if no id provided" do
		sign_in users(:user_for_auth_tests_only)
		get :index
		assert_response :error
	end
	
end