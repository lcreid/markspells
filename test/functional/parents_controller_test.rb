require 'test_helper'

class ParentsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
	
  test "should get show" do
    sign_in users(:juana_senior)
    get :show, :id => @controller.current_user.id
    assert_response :success
    
    assert_select "div#parent-home", 1, "Missing parent home div" do
      assert_select "div.child", 2, "Wrong number of children" do |children|
        assert_select children[0], "div.for-school", 1, "Missing school work div" do
          assert_select "div.do-now", 1, "Missing do now div" do
            assert_select 'table', 1, "Missing do now table"
          end
          assert_select "div.up-next", 1, "Missing up next div" do
            assert_select 'table', 1, "Missing up next table"
          end
          assert_select "div.done-recently", 1, "Missing done recently div" do
            assert_select 'table', 1, "Missing done table" do
              assert_select 'tr', 2, "Wrong number of rows in done table"
            end
          end
        end
	  end
	  
      assert_select "div#lists", 1, "Missing word lists" do
			assert_select 'a', "Create a New Word List", "Missing create word list link."
			assert_select( 'table#word-list', nil, "Missing word list table") do
				assert_select 'tr' do |row|
				 assert_select row[1], 'td' do |col|
					 assert_select col[0], 'td', 'Each coming soon', "Missing or incorrect title."
					assert_select col[1], 'td', (Date.today + 1).to_s, "Missing or incorrect due date."
					assert_select col[2], 'td' do
					  assert_select 'a', "Study",  "Missing study link."
					end
					assert_select col[3], 'td' do
					  assert_select 'a', "Edit",  "Missing edit link."
					end
					assert_select col[4], 'td' do
					  assert_select 'a', "Assign",  "Missing assign link."
					end
				 end
			  end
			end
      end
    end
  end

  test "should fail to get show if no ID provided" do
    sign_in users(:user_for_auth_tests_only)
    get :show
    assert_response :error
  end

  test "should redirect if user not logged in" do
    get :show, :id => 0
    assert_redirected_to new_user_session_path
  end

end
