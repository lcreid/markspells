require 'test_helper'

class ListStatsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  test "should post reset" do
    sign_in users(:user_for_auth_tests_only)
    
    user = @controller.current_user
    
#    puts "User ID: " + user.id.to_s
    
    ps = user.practice_sessions.create(:word_list_id => list_items(:each).word_list_id)

    ps.student_responses.create(
      :word_id => list_items(:each).id,
      :word => list_items(:each).word,
      :student_response => list_items(:each).word
    )

    @request.env['HTTP_REFERER'] = 'http://test.com/sessions/new'

    post :reset
    assert_equal 0, user.current_practice_session.words_tried
    assert_redirected_to :back
  end

  test "redirect if user not logged in" do
    @request.env['HTTP_REFERER'] = 'http://test.com/sessions/new'
    post :reset
    assert_redirected_to new_user_session_path
  end
end
