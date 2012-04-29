require 'test_helper'

class ListStatsControllerTest < ActionController::TestCase
  test "should post reset" do
    user = @controller.current_user
    
#    puts "OldUser ID: " + user.id.to_s
    
    ps = user.practice_sessions.create(:word_list_id => list_items(:each).word_list_id)

    sr = StudentResponse.new
    sr.word_id = list_items(:each).id
    sr.word = list_items(:each).word
    sr.student_response = list_items(:each).word
    sr.old_user_id = @controller.current_user_id
    sr.save

#    puts "controller user id: " + @controller.current_user_id.to_s +
#    	" StudentResponse.user_id: " + sr.user_id.to_s +
#    	" StudentResponse.all.count: " + StudentResponse.all.count.to_s
#    @controller.current_user_id
    @request.env['HTTP_REFERER'] = 'http://test.com/sessions/new'

    post :reset, :word_list_id => ps.word_list_id
    assert_equal 0, user.current_practice_session.words_tried
    assert_redirected_to :back
  end

end
