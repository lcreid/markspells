require 'test_helper'

class ListItemsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test "practice redirects if user no logged in" do
    user = users(:user_for_auth_tests_only)
    user.practice_sessions.create(:word_list_id => list_items(:pouch).word_list_id)

    get :practice, :id => list_items(:pouch).id
    assert_redirected_to new_user_session_path
  end
  
  test "test redirects if user no logged in" do
    get :test
    assert_redirected_to new_user_session_path
  end
  
  test "check redirects if user no logged in" do
    user = users(:user_for_auth_tests_only)
    user.practice_sessions.create(:word_list_id => list_items(:watch).word_list_id)
    post :check, :word_id => list_items(:watch).id, :word => list_items(:watch).word, :student_response => list_items(:watch).word
    assert_redirected_to new_user_session_path
  end
  
  test "should get practice first word" do
    sign_in users(:user_for_auth_tests_only)
    user = @controller.current_user
    user.practice_sessions.create(:word_list_id => list_items(:pouch).word_list_id)

    assert_equal 1, @controller.current_user.practice_sessions.size

    get :practice, :id => list_items(:each).id
    assert_response :success

    assert_select 'div#messages', "", "Missing or wrong messages"
    assert_select 'div#errors', "", "Missing or wrong messages"
    assert_select 'div#word-test', nil, "Missing test"
    assert_select 'object#dewplayer', nil, "Missing mp3 player"
    assert_select 'div#beginning-of-sentence', "Try to spell", "Missing or wrong sentence beginning"
    assert_select 'div#student-response-word', nil, "Missing or wrong student response word"
    assert_select 'div#end-of-sentence', "word as best you can.", "Missing or wrong sentence end"
    assert_select 'div.links input', nil, "Selector doesn't work"
    assert_select 'div.links' do
      assert_select 'input', nil, "Missing submit button"
      assert_select 'a', nil, "Missing skip link"
    end
    
    assert_select 'div#to-study', nil, "Missing study link div" do
    	assert_select 'a', "Study this list",  "Missing or incorrect study link."
    end
    
    assert_select 'div#to-all-lists', nil, "Missing all lists link div" do
    	assert_select 'a', "Pick another list",  "Missing or incorrect all lists link."
    end

    assert_select 'div#stats' do
      assert_select 'form' do
        assert_select 'input', nil, 'Missing reset button'
      end
      assert_select 'table#stats' do
        assert_select 'tr' do |row|
          assert_select row[0], 'td' do |col|
            assert_select col[0], 'td', "Words in list"
            assert_select col[1], 'td', "20"
          end
          assert_select row[1], 'td' do |col|
            assert_select col[0], 'td', "Words correct"
            assert_select col[1], 'td', "0"
          end
          assert_select row[2], 'td' do |col|
            assert_select col[0], 'td', "Words untried"
            assert_select col[1], 'td', "20"
          end
          assert_select row[3], 'td' do |col|
            assert_select col[0], 'td', "Words left"
            assert_select col[1], 'td', "20"
          end
        end
      end
    end
  end

  test "should get practice arbitrary word" do
    sign_in users(:user_for_auth_tests_only)
    user = @controller.current_user
    user.practice_sessions.create(:word_list_id => list_items(:pouch).word_list_id)

    get :practice, :id => list_items(:pouch).id
    assert_response :success
  end

  test "word spelled correctly" do
    sign_in users(:user_for_auth_tests_only)
    @controller.current_user.practice_sessions.create(:word_list_id => list_items(:pouch).word_list_id)
#    puts @controller.current_user.current_practice_session.inspect
    post :check, :word_id => list_items(:pouch).id, :word => list_items(:pouch).word, :student_response => "Pouch"
    assert_redirected_to practice_list_item_path(
      @controller.current_user.current_practice_session.
      next_word_not_yet_answered_correctly(list_items(:pouch)).id)
#    puts @controller.current_user.current_practice_session.inspect
#    assert ! @controller.current_user.current_practice_session.student_responses.last.start_time.nil?, "Start time nil."
    assert ! @controller.current_user.current_practice_session.student_responses.last.end_time.nil?, "Start time nil."
  end

  test "word spelled incorrectly" do
    sign_in users(:user_for_auth_tests_only)
    @controller.current_user.practice_sessions.create(:word_list_id => list_items(:pouch).word_list_id)
    post :check, :word_id => list_items(:pouch).id, :word => list_items(:pouch).word, :student_response => "Pooch"
    assert_redirected_to practice_list_item_path(list_items(:pouch).id)
  end

  test "last word in list spelled correctly" do
    sign_in users(:user_for_auth_tests_only)
    @controller.current_user.practice_sessions.create(:word_list_id => list_items(:watch).word_list_id)
    post :check, :word_id => list_items(:watch).id, :word => list_items(:watch).word, :student_response => list_items(:watch).word
    assert_redirected_to practice_list_item_path(list_items(:each).id)
  end

  test "should get test" do
    sign_in users(:user_for_auth_tests_only)
    get :test
    assert_response :success
  end

  test "Check that we get the same cookie for the duration" do
    sign_in users(:user_for_auth_tests_only)
    user = @controller.current_user
    user.practice_sessions.create(:word_list_id => list_items(:pouch).word_list_id)
#    puts cookies[:current_user]
#    puts "In the test case: " + @controller.current_user_id.to_s
    assert_no_difference '@controller.current_user.id', "Got a different user id" do
      get :practice, :id => list_items(:pouch).id
      assert_response :success
    end
#    puts "At the end of the test case: " + @controller.current_user_id.to_s
  end

end
