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
