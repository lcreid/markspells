require 'test_helper'

class AssignmentTest < ActiveSupport::TestCase
  test "assignment incomplete" do 
    assert assignments(:one_incomplete_assignment).incomplete?, "expected incomplete assignment"
  end
  
  test "assignment complete" do 
    assert assignments(:one_complete_assignment).complete?, "expected complete assignment"
  end
  
  test "assignment complete and incomplete" do 
    assert assignments(:one_mixed_assignment).complete?, "expected complete assignment with one inomplete"
    assert ! assignments(:one_mixed_assignment).incomplete?, "expected complete assignment with one inomplete"
  end
end
