require 'test_helper'

class ListStatsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  test "should post reset" do
    sign_in users(:joe)
    
    user = @controller.current_user
    
#    puts "User ID: " + user.id.to_s
    
    ps = user.practice_sessions.create(:word_list_id => list_items(:each).word_list_id)

    sr = StudentResponse.new
    sr.word_id = list_items(:each).id
    sr.word = list_items(:each).word
    sr.student_response = list_items(:each).word
    sr.user_id = @controller.old_current_user_id
    sr.save

#    puts "controller user id: " + @controller.old_current_user_id.to_s +
#    	" StudentResponse.user_id: " + sr.user_id.to_s +
#    	" StudentResponse.all.count: " + StudentResponse.all.count.to_s
#    @controller.old_current_user_id
    @request.env['HTTP_REFERER'] = 'http://test.com/sessions/new'

    post :reset
    assert_equal 0, user.current_practice_session.words_tried
    assert_redirected_to :back
  end

  test "redirect if user no logged in" do
    @request.env['HTTP_REFERER'] = 'http://test.com/sessions/new'
    post :reset
    assert_redirected_to new_user_session_path
  end
end
