require 'test_helper'

class PracticeSessionTest < ActiveSupport::TestCase
  test "results" do
    ps = PracticeSession.new(:user_id => 0, :word_list_id => word_lists(:one).id)
    assert_equal 20, ps.total_words, "Total words"
    assert_equal 0, ps.words_correct, "Words correct"
    assert_equal 20, ps.words_untried, "Words untried"
    assert_equal 20, ps.words_left, "Words left"

    # Response is correct
    r = StudentResponse.new
    r.user_id = 0
    r.word = list_items(:each).word
    r.word_id = list_items(:each).id
    r.student_response = list_items(:each).word
    r.save! # TODO: Should the model save itself? Should the stats depend on the database?
    assert_equal 20, ps.total_words, "Total words"
    assert_equal 1, ps.words_correct, "Words correct"
    assert_equal 19, ps.words_untried, "Words untried"
    assert_equal 19, ps.words_left, "Words left"

    # Response is wrong for new word
    r = StudentResponse.new
    r.user_id = 0
    r.word = list_items(:speech).word
    r.word_id = list_items(:speech).id
    r.student_response = "speach"
    r.save! # TODO: Should the model save itself? Should the stats depend on the database?
    assert_equal 20, ps.total_words, "Total words"
    assert_equal 1, ps.words_correct, "Words correct"
    assert_equal 18, ps.words_untried, "Words untried"
    assert_equal 19, ps.words_left, "Words left"

    # Response is correct for previously wrong word
    r = StudentResponse.new
    r.user_id = 0
    r.word = list_items(:speech).word
    r.word_id = list_items(:speech).id
    r.student_response = "speech"
    r.save! # TODO: Should the model save itself? Should the stats depend on the database?
    assert_equal 20, ps.total_words, "Total words"
    assert_equal 2, ps.words_correct, "Words correct"
    assert_equal 18, ps.words_untried, "Words untried"
    assert_equal 18, ps.words_left, "Words left"

    # Previously spelled correctly is correct again
    r = StudentResponse.new
    r.user_id = 0
    r.word = list_items(:each).word
    r.word_id = list_items(:each).id
    r.student_response = list_items(:each).word
    r.save! # TODO: Should the model save itself? Should the stats depend on the database?
    assert_equal 20, ps.total_words, "Total words"
    assert_equal 2, ps.words_correct, "Words correct"
    assert_equal 18, ps.words_untried, "Words untried"
    assert_equal 18, ps.words_left, "Words left"

    # Test another user id
    ls2 = PracticeSession.new(:user_id => 1, :word_list_id => word_lists(:one).id)
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
  end
  
  test "user response has leading whitespace" do
    ls = PracticeSession.new(:user_id => 0, :word_list_id => word_lists(:three).id)
    sr = StudentResponse.new
    sr.word_id = list_items(:cinch).id
    sr.word = list_items(:cinch).word
    sr.user_id = 0
    sr.student_response = ' ' + list_items(:cinch).word
    sr.save

    assert_equal 1, ls.words_correct
  end
  
  test "user response has trailing whitespace" do
    ls = PracticeSession.new(:user_id => 0, :word_list_id => word_lists(:three).id)
    sr = StudentResponse.new
    sr.word_id = list_items(:cinch).id
    sr.word = list_items(:cinch).word
    sr.user_id = 0
    sr.student_response = list_items(:cinch).word + ' '
    sr.save

    assert_equal 1, ls.words_correct
  end
end
