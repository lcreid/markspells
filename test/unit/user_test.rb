require 'test_helper'

class UserTest < ActiveSupport::TestCase
	
	test "add children" do
		joe = users(:joe)
		children = [ users(:one_each).id, users(:one_mixed).id ]
		
		assert_difference 'joe.children.count', 2 do
			joe.add_children(children)
		end
	end
		
	test "stats separated by word list" do
		u = users(:short_list_two_student)
		assert_equal 110, u.assignments[1].duration
		assert_equal 30, u.assignments[0].duration
		assert_equal 1, u.assignments[0].n_tries
		assert_equal 1, u.assignments[1].n_tries
	end
	
	test "assigned and unassigned" do
		u = users(:juana_senior)
		word_list_id = word_lists(:wl_each_complete).id
		assert_equal 1, u.children_assigned_to(word_list_id).count
		assert_equal users(:one_each), u.children_assigned_to(word_list_id).first.assigned_to
		assert_equal 1, u.children_unassigned_to(word_list_id).count
		assert_equal users(:one_mixed), u.children_unassigned_to(word_list_id).first
	end
	
	test "assigned and unassigned part 2" do
		u = users(:juana_senior)
		word_list_id = u.word_lists.first.id
		assert_equal 1, u.children_assigned_to(word_list_id).count
		assert_equal users(:one_each), u.children_assigned_to(word_list_id).first.assigned_to
		assert_equal 1, u.children_unassigned_to(word_list_id).count
		assert_equal users(:one_mixed), u.children_unassigned_to(word_list_id).first
	end
	
  test "One incomplete assignment" do
    u = users(:one_incomplete)
    assert_equal 1, u.incomplete_assignments.count, "Expected one incomplete"
    assert_equal 0, u.complete_assignments.count, "Expected no completes"
  end
  
  test "One complete assignment" do
    u = users(:one_complete)
    assert_equal 0, u.incomplete_assignments.count, "Expected no incompletes"
    assert_equal 1, u.complete_assignments.count, "Expected one complete"
  end
  
  test "Two practice sessions, one assignment, one practice session not complete" do
    u = users(:one_mixed)
    assert_equal 0, u.incomplete_assignments.count, "Expected no incompletes"
    assert_equal 1, u.complete_assignments.count, "Expected one complete"
  end
  
  test "Three assignments" do 
    u = users(:one_each)
    assert_equal 1, u.complete_assignments.count, "Expected one complete"
    assert_equal assignments(:one_each_assignment_complete), u.complete_assignments[0], "Wrong assignment complete"
    assert_equal 1, u.overdue_assignments.count, "Expected one overdue"
    assert_equal assignments(:one_each_assignment_overdue), u.overdue_assignments[0], "Wrong assignment overdue"
    assert_equal 1, u.coming_soon_assignments.count, "Expected one coming soon"
    assert_equal assignments(:one_each_assignment_coming_soon), u.coming_soon_assignments[0], "Wrong assignment coming soon"
    assert_equal 2, u.incomplete_assignments.count, "Expected no incompletes"
  end    
  
  test "Tried list two times" do
    user = User.new(:id => 0, :email => "zero@example.com", :password => "password") and user.save!
    
    ps = user.practice_sessions.create(:word_list_id => word_lists(:basic_cuadrant_test).id)
    sr = StudentResponse.new
    sr.word_id = list_items(:the).id
    sr.word = list_items(:the).word
    sr.user_id = 0
    sr.student_response = list_items(:the).word
    sr.save!
    
    sr = StudentResponse.new
    sr.word_id = list_items(:easy).id
    sr.word = list_items(:easy).word
    sr.user_id = 0
    sr.student_response = list_items(:easy).word
    sr.save!
    
    sr = StudentResponse.new
    sr.word_id = list_items(:words).id
    sr.word = list_items(:words).word
    sr.user_id = 0
    sr.student_response = list_items(:words).word
    sr.save!
    
    ps = user.practice_sessions.create(:word_list_id => word_lists(:basic_cuadrant_test).id)
    sr = StudentResponse.new
    sr.word_id = list_items(:the).id
    sr.word = list_items(:the).word
    sr.user_id = 0
    sr.student_response = list_items(:the).word
    sr.save!
    
    sr = StudentResponse.new
    sr.word_id = list_items(:easy).id
    sr.word = list_items(:easy).word
    sr.user_id = 0
    sr.student_response = list_items(:easy).word
    sr.save!
    
    sr = StudentResponse.new
    sr.word_id = list_items(:words).id
    sr.word = list_items(:words).word
    sr.user_id = 0
    sr.student_response = list_items(:words).word
    sr.save!

    responses = user.all_results(word_lists(:basic_cuadrant_test).id)
    assert_equal 2, responses.size
    assert_equal ps, user.current_practice_session
  end
  
  test "current practice session" do
    user = User.create(:email => "zero@example.com", :password => "password")
    user.practice_sessions.create(:word_list_id => list_items(:the).word_list_id)
    assert_equal 1, user.practice_sessions.size
    assert_equal list_items(:the).word_list_id, user.current_practice_session.word_list_id
  end
  
  # TODO: Move reset into user where it belongs.
  test "reset practice session" do 
    user = users(:larry)
    before_current = user.current_practice_session.student_responses.count
    assert 0 < before_current, "Use a user with some responses"
    user.reset
    assert_equal 0, user.current_practice_session.student_responses.count
  end
end
