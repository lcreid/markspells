require 'test_helper'

class StudentsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test "should get show" do
    sign_in users(:one_each)
    get :show, :id => @controller.current_user.id
    assert_response :success
    
    assert_select "div#student-home", 1, "Missing student home div" do
      assert_select "div#for-school", 1, "Missing school work div" do
        assert_select "div#do-now", 1, "Missing do now div" do
          assert_select 'table', 1, "Missing do now table" do
            assert_select 'tr', 2, "Wrong number of rows in do now table" do |row|
              assert_select row[1], 'td' do |col|
                assert_select col[0], 'td', 'Each overdue', "Missing or incorrect title."
                assert_select col[1], 'td', (Date.today - 2.days).to_s, "Missing or incorrect due date."
                assert_select col[2], 'td' do
                  assert_select 'a', 'Practice', "Missing or incorrect practice link."
                end
                assert_select col[3], 'td' do
                  assert_select 'a', "Study",  "Missing or incorrect study link."
                end
              end
            end
          end
        end
        assert_select "div#up-next", 1, "Missing up next div" do
          assert_select 'table', 1, "Missing up next table" do
            assert_select 'tr', 2, "Wrong number of rows in up next table" do |row|
              assert_select row[1], 'td' do |col|
                assert_select col[0], 'td', 'Each coming soon', "Missing or incorrect title."
                assert_select col[1], 'td', (Date.today + 1.day).to_s, "Missing or incorrect due date."
                assert_select col[2], 'td' do
                  assert_select 'a', 'Practice', "Missing or incorrect practice link."
                end
                assert_select col[3], 'td' do
                  assert_select 'a', "Study",  "Missing or incorrect study link."
                end
              end
            end
          end
        end
        assert_select "div#done-recently", 1, "Missing done recently div" do
          assert_select 'table', 1, "Missing done table" do
            assert_select 'tr', 2, "Wrong number of rows in done table" do |row|
              assert_select row[1], 'td' do |col|
                assert_select col[0], 'td', 'Each complete', "Missing or incorrect title."
                assert_select col[1], 'td', (Date.today - 2.days).to_s, "Missing or incorrect due date."
                assert_select col[2], 'td' do
                  assert_select 'a', 'Practice', "Missing or incorrect practice link."
                end
                assert_select col[3], 'td' do
                  assert_select 'a', "Study",  "Missing or incorrect study link."
                end
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
