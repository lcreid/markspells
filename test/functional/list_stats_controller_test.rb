require 'test_helper'

class ListStatsControllerTest < ActionController::TestCase
  test "should post reset" do
    @controller.current_user_id
    ls = ListStatsHelper::ListStats.new(@controller.current_user_id, 1)
    sr = StudentResponse.new
    sr.word_id = list_items(:each).id
    sr.word = list_items(:each).word
    sr.student_response = list_items(:each).word
    sr.user_id = @controller.current_user_id
    sr.save
#    puts "controller user id: " + @controller.current_user_id.to_s +
#    	" StudentResponse.user_id: " + sr.user_id.to_s +
#    	" StudentResponse.all.count: " + StudentResponse.all.count.to_s
#    @controller.current_user_id
    @request.env['HTTP_REFERER'] = 'http://test.com/sessions/new'

    assert_difference 'StudentResponse.all.count', -1 do
      post :reset, :word_list_id => ls.word_list_id
      assert_redirected_to :back
    end
  end

end
