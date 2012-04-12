require 'test_helper'

class StudentResponseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
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
