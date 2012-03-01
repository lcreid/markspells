require 'test_helper'

class ListHelperTest < ActionView::TestCase
  test "results" do
    ls = ListStats.new(0, word_lists(:one).id)
    assert_equal 20, ls.total_words, "Total words"
    assert_equal 0, ls.words_correct, "Words correct"
    assert_equal 20, ls.words_untried, "Words untried"
    assert_equal 20, ls.words_left, "Words left"

    # Response is correct
    r = StudentResponse.new
    r.user_id = 0
    r.word = list_items(:each).word
    r.word_id = list_items(:each).id
    r.student_response = list_items(:each).word
    r.save! # TODO: Should the model save itself? Should the stats depend on the database?
    assert_equal 20, ls.total_words, "Total words"
    assert_equal 1, ls.words_correct, "Words correct"
    assert_equal 19, ls.words_untried, "Words untried"
    assert_equal 19, ls.words_left, "Words left"

    # Response is wrong for new word
    r = StudentResponse.new
    r.user_id = 0
    r.word = list_items(:speech).word
    r.word_id = list_items(:speech).id
    r.student_response = "speach"
    r.save! # TODO: Should the model save itself? Should the stats depend on the database?
    assert_equal 20, ls.total_words, "Total words"
    assert_equal 1, ls.words_correct, "Words correct"
    assert_equal 18, ls.words_untried, "Words untried"
    assert_equal 19, ls.words_left, "Words left"

    # Response is correct for previously wrong word
    r = StudentResponse.new
    r.user_id = 0
    r.word = list_items(:speech).word
    r.word_id = list_items(:speech).id
    r.student_response = "speech"
    r.save! # TODO: Should the model save itself? Should the stats depend on the database?
    assert_equal 20, ls.total_words, "Total words"
    assert_equal 2, ls.words_correct, "Words correct"
    assert_equal 18, ls.words_untried, "Words untried"
    assert_equal 18, ls.words_left, "Words left"

    # Previously spelled correctly is correct again
    r = StudentResponse.new
    r.user_id = 0
    r.word = list_items(:each).word
    r.word_id = list_items(:each).id
    r.student_response = list_items(:each).word
    r.save! # TODO: Should the model save itself? Should the stats depend on the database?
    assert_equal 20, ls.total_words, "Total words"
    assert_equal 2, ls.words_correct, "Words correct"
    assert_equal 18, ls.words_untried, "Words untried"
    assert_equal 18, ls.words_left, "Words left"

    # Test another user id
    ls2 = ListStats.new(1, word_lists(:one).id)
    assert_equal 20, ls2.total_words, "Total words"
    assert_equal 0, ls2.words_correct, "Words correct"
    assert_equal 20, ls2.words_untried, "Words untried"
    assert_equal 20, ls2.words_left, "Words left"

    r = StudentResponse.new
    r.user_id = 1
    r.word = list_items(:each).word
    r.word_id = list_items(:each).id
    r.student_response = list_items(:each).word
    r.save! # TODO: Should the model save itself? Should the stats depend on the database?
    assert_equal 20, ls2.total_words, "Total words"
    assert_equal 1, ls2.words_correct, "Words correct"
    assert_equal 19, ls2.words_untried, "Words untried"
    assert_equal 19, ls2.words_left, "Words left"

    assert_difference 'StudentResponse.all.count',
    - StudentResponse.where(:user_id => 0).count do
      ls.reset
    end
  end

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

end
