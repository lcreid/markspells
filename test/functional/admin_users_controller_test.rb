require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  test 'get users' do
    sign_in users(:admin_for_auth_tests_only)
    get :index
    assert_response :success
    
    assert_select 'table#user-list', nil, "Missing or wrong table." do
      assert_select 'tr', nil, "Wrong number of users" do |row| # remember to add one for the header
        assert_select row[1], 'td' do |col| # Remember to skip the header row
          assert_select col[0], 'td', "AAA", 'Missing or wrong user or order not correct'
          assert_select col[1], 'td', "user_for_auth_tests_only@example.com"
          assert_select col[2], 'td', "token"
          assert_select col[3], 'td', "2012-05-01 00:00:00 UTC"
          assert_select col[4], 'td', "2012-04-30 00:00:00 UTC"
          assert_select col[5], 'td', "2"
          assert_select col[6], 'td', "2012-05-02 00:00:00 UTC"
          assert_select col[7], 'td', "2012-05-01 00:00:00 UTC"
          assert_select col[8], 'td', "127.0.0.1"
          assert_select col[9], 'td', "127.0.0.2"
          assert_select col[10], 'td', "Fake_GUID"
          # TODO: Make this a checkbox
          assert_select col[11], 'td', "false"
        end
      end
    end
  end
  
  test 'go to not found page if user is not admin' do
    sign_in users(:user_for_auth_tests_only)
    assert_raise (ActionController::RoutingError) do
      get :index
    end
  end
  
  test 'go to not found page if not signed in' do
    assert_raise (ActionController::RoutingError) do
      get :index
    end
  end
  
  test 'new user' do 
    sign_in users(:admin_for_auth_tests_only)
    get :new
    assert_response :success
  end
  
  test 'new user not found if user is not admin' do 
    sign_in users(:user_for_auth_tests_only)
    assert_raise (ActionController::RoutingError) do
      get :new
    end
  end
  
  test 'new user not found if not signed in' do
    assert_raise (ActionController::RoutingError) do
      get :new
    end
  end
  
  test 'edit user' do 
    sign_in users(:admin_for_auth_tests_only)
    get :edit, :id => users(:user_for_auth_tests_only).id
    assert_response :success
  end
  
  test 'edit user not found if user is not admin' do 
    sign_in users(:user_for_auth_tests_only)
    assert_raise (ActionController::RoutingError) do
      get :edit, :id => users(:user_for_auth_tests_only).id
    end
  end
  
  test 'edit user not found if not signed in' do
    assert_raise (ActionController::RoutingError) do
      get :edit, :id => users(:user_for_auth_tests_only).id
    end
  end
  
  test 'create user not found if user is not admin' do 
    sign_in users(:user_for_auth_tests_only)
    assert_raise (ActionController::RoutingError) do
      post :create
    end
  end
  
  test 'create user not found if not signed in' do
    assert_raise (ActionController::RoutingError) do
      post :create
    end
  end
  
  test 'update user not found if user is not admin' do 
    sign_in users(:user_for_auth_tests_only)
    assert_raise (ActionController::RoutingError) do
      post :update
    end
  end
  
  test 'update user not found if not signed in' do
    assert_raise (ActionController::RoutingError) do
      post :update
    end
  end
end

