require 'test_helper'

class StudentResponseTest < ActiveSupport::TestCase
  test "next when some words are correct" do
    # Response is correct
    r = StudentResponse.new
    r.user_id = 0
    r.word = list_items(:speech).word
    r.word_id = list_items(:speech).id
    r.student_response = list_items(:speech).word
    r.save! # TODO: Should the model save itself? Should the stats depend on the database?
    li = list_items(:each).next_word_not_yet_answered_correctly(0)
    assert_equal list_items(:hitch), li, "Didn't skip correct word"
  end

  test "next when all words are correct" do
    ListItem.all.each do |li|
      r = StudentResponse.new
      r.user_id = 0
      r.word = li.word
      r.word_id = li.id
      r.student_response = li.word
      r.save! # TODO: Should the model save itself? Should the stats depend on the database?
    end
    li = list_items(:watch).next_word_not_yet_answered_correctly(0)
    assert_equal list_items(:each), li, "Didn't go to next word"
  end
  
  test "Spelling word is capitalized in sentence" do
    sr = StudentResponse.new
    sr.word_id = list_items(:cinch).id
    sr.word = list_items(:cinch).word
    sr.user_id = 0
    sr.student_response = "Cinch"
    sr.save
    
    assert sr.correct
  end
  
  test "is correct with no student_response" do
	  r = StudentResponse.new do |r|
		  r.word = "a"
	  end
	  assert ! r.correct
  end
  
  test "is correct with correct student_response" do
	  r = StudentResponse.new do |r|
		  r.word = "a"
		  r.student_response = "a"
	  end
	  assert r.correct
  end
  
  test "is correct with no student_response then correct student_response" do
	  r = StudentResponse.new do |r|
		  r.word = "a"
	  end
	  assert ! r.correct
	  
	  r.student_response = "a"
	  assert r.correct
  end
  
  test "Green list" do
    list = StudentResponse.green_list(:word_list_id => word_lists(:basic_cuadrant_test).id)
    assert_equal 2, list.size
    assert list.detect { |x| x.name == "Cathy Green" }
    assert list.detect { |x| x.name == "Marc Green" }
  end
  
  test "Empty green list" do
    list = StudentResponse.green_list(:word_list_id => word_lists(:non_existent_list).id)
    assert_empty list
  end
  
  test "Red list" do
    list = StudentResponse.red_list(:word_list_id => word_lists(:basic_cuadrant_test).id)
    assert_equal 1, list.size
    assert_equal "Larry Red", list[0].name
  end
  
  test "Orange list" do
    list = StudentResponse.orange_list(:word_list_id => word_lists(:basic_cuadrant_test).id)
    assert_equal 1, list.size
    assert_equal "Linda Orange", list[0].name
  end
  
  test "Yellow list" do
    list = StudentResponse.yellow_list(:word_list_id => word_lists(:basic_cuadrant_test).id)
    assert_equal 1, list.size
    assert_equal "Nicky Yellow", list[0].name
  end
end
