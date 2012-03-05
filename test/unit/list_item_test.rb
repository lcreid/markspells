require 'test_helper'

class ListItemTest < ActiveSupport::TestCase
  test "next list_item" do
    assert_equal list_items(:speech), list_items(:each).next_word_not_yet_answered_correctly(0)
  end

  test "at last word and first word is correct already" do
    sr = StudentResponse.new
    #    list_items(:each) do |li|
    #      sr.word_id = li.id
    #      sr.word = li.word
    #      sr.user_id = 0
    #      sr.student_response = li.word
    #      sr.save
    #    end
    sr.word_id = list_items(:each).id
    sr.word = list_items(:each).word
    sr.user_id = 0
    sr.student_response = list_items(:each).word
    sr.save

    assert_equal list_items(:speech), list_items(:watch).next_word_not_yet_answered_correctly(0)
  end
  
  test "Spelling word is capitalized in sentence" do
    w = list_items(:cinch)
   
    assert_equal '', w.beginning_of_sentence
    assert_equal ' your belt tightly or your pants will fall down.', w.end_of_sentence
  end

end
