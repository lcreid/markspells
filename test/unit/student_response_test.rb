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
end
