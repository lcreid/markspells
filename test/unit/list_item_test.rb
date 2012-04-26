require 'test_helper'

class ListItemTest < ActiveSupport::TestCase
  
  test "Spelling word is capitalized in sentence" do
    w = list_items(:cinch)
   
    assert_equal '', w.beginning_of_sentence
    assert_equal ' your belt tightly or your pants will fall down.', w.end_of_sentence
  end

end
