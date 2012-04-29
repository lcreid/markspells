require 'test_helper'

class OldUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "Tried list two times" do
    user = OldUser.new(:id => 0) and user.save!
    
    ps = user.practice_sessions.create(:word_list_id => word_lists(:basic_cuadrant_test).id)
    sr = StudentResponse.new
    sr.word_id = list_items(:the).id
    sr.word = list_items(:the).word
    sr.old_user_id = 0
    sr.student_response = list_items(:the).word
    sr.save!
    
    sr = StudentResponse.new
    sr.word_id = list_items(:easy).id
    sr.word = list_items(:easy).word
    sr.old_user_id = 0
    sr.student_response = list_items(:easy).word
    sr.save!
    
    sr = StudentResponse.new
    sr.word_id = list_items(:words).id
    sr.word = list_items(:words).word
    sr.old_user_id = 0
    sr.student_response = list_items(:words).word
    sr.save!
    
    ps = user.practice_sessions.create(:word_list_id => word_lists(:basic_cuadrant_test).id)
    sr = StudentResponse.new
    sr.word_id = list_items(:the).id
    sr.word = list_items(:the).word
    sr.old_user_id = 0
    sr.student_response = list_items(:the).word
    sr.save!
    
    sr = StudentResponse.new
    sr.word_id = list_items(:easy).id
    sr.word = list_items(:easy).word
    sr.old_user_id = 0
    sr.student_response = list_items(:easy).word
    sr.save!
    
    sr = StudentResponse.new
    sr.word_id = list_items(:words).id
    sr.word = list_items(:words).word
    sr.old_user_id = 0
    sr.student_response = list_items(:words).word
    sr.save!

    responses = user.all_results(word_lists(:basic_cuadrant_test).id)
    assert_equal 2, responses.size
    assert_equal ps, user.current_practice_session
  end
  
  test "current practice session" do
    user = OldUser.create
    user.practice_sessions.create(:word_list_id => list_items(:the).word_list_id)
    assert_equal 1, user.practice_sessions.size
    assert_equal list_items(:the).word_list_id, user.current_practice_session.word_list_id
  end
  
  # TODO: Move reset into user where it belongs.
  test "reset practice session" do 
    user = old_users(:larry)
    before_current = user.current_practice_session.student_responses.count
    assert 0 < before_current, "Use a user with some responses"
    user.reset
    assert_equal 0, user.current_practice_session.student_responses.count
  end
end
