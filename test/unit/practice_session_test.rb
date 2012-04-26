require 'test_helper'

class PracticeSessionTest < ActiveSupport::TestCase
  test "results" do
    ps = PracticeSession.new(:user_id => 0, :word_list_id => word_lists(:one).id)
    assert_equal 20, ps.total_words, "Total words"
    assert_equal 0, ps.words_correct, "Words correct"
    assert_equal 20, ps.words_untried, "Words untried"
    assert_equal 20, ps.words_left, "Words left"

    # Response is correct
    ps.student_responses.build do |r|
      r.user_id = 0
      r.word = list_items(:each).word
      r.word_id = list_items(:each).id
      r.student_response = list_items(:each).word
    end
#    r.save! # TODO: Should the model save itself? Should the stats depend on the database?
    assert_equal 20, ps.total_words, "Total words"
    assert_equal 1, ps.words_correct, "Words correct"
    assert_equal 19, ps.words_untried, "Words untried"
    assert_equal 19, ps.words_left, "Words left"

    # Response is wrong for new word
    ps.student_responses.build do |r|
      r.user_id = 0
      r.word = list_items(:speech).word
      r.word_id = list_items(:speech).id
      r.student_response = "speach"
    end

    assert_equal 20, ps.total_words, "Total words"
    assert_equal 1, ps.words_correct, "Words correct"
    assert_equal 18, ps.words_untried, "Words untried"
    assert_equal 19, ps.words_left, "Words left"

    # Response is correct for previously wrong word
    ps.student_responses.build do |r|
      r.user_id = 0
      r.word = list_items(:speech).word
      r.word_id = list_items(:speech).id
      r.student_response = "speech"
    end

    assert_equal 20, ps.total_words, "Total words"
    assert_equal 2, ps.words_correct, "Words correct"
    assert_equal 18, ps.words_untried, "Words untried"
    assert_equal 18, ps.words_left, "Words left"

    # Previously spelled correctly is correct again
    ps.student_responses.build do |r|
      r.user_id = 0
      r.word = list_items(:each).word
      r.word_id = list_items(:each).id
      r.student_response = list_items(:each).word
    end

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

    ls2.student_responses.build do |r|
      r.user_id = 1
      r.word = list_items(:each).word
      r.word_id = list_items(:each).id
      r.student_response = list_items(:each).word
    end
    
    assert_equal 20, ls2.total_words, "Total words"
    assert_equal 1, ls2.words_correct, "Words correct"
    assert_equal 19, ls2.words_untried, "Words untried"
    assert_equal 19, ls2.words_left, "Words left"
  end
  
  test "user response has leading whitespace" do
    ps = PracticeSession.new(:user_id => 0, :word_list_id => word_lists(:three).id)
    ps.student_responses.build do |sr|
      sr.word_id = list_items(:cinch).id
      sr.word = list_items(:cinch).word
      sr.user_id = 0
      sr.student_response = ' ' + list_items(:cinch).word
    end

    assert_equal 1, ps.words_correct
  end
  
  test "user response has trailing whitespace" do
    ps = PracticeSession.new(:user_id => 0, :word_list_id => word_lists(:three).id)
    ps.student_responses.build do |sr|
      sr.word_id = list_items(:cinch).id
      sr.word = list_items(:cinch).word
      sr.user_id = 0
      sr.student_response = list_items(:cinch).word + ' '
    end

    assert_equal 1, ps.words_correct
  end
  
  test "next list_item" do
    u = User.create
    u.practice_sessions.create(:word_list_id => word_lists(:one).id)
    assert_equal list_items(:speech), list_items(:each).next_word_not_yet_answered_correctly(u.id)
  end

  test "at last word and first word is correct already" do
    u = User.create
    u.practice_sessions.create(:word_list_id => word_lists(:one).id)
    u.current_practice_session.student_responses.create(
      :user_id => u.id,
      :word_id => list_items(:each).id,
      :word => list_items(:each).word,
      :student_response => list_items(:each).word)

#    puts "responses: " + u.current_practice_session.student_responses.to_s

    assert_equal list_items(:speech), list_items(:watch).next_word_not_yet_answered_correctly(u.id)
  end

  test "next when some words are correct" do
    # Response is correct
    u = User.create
    u.practice_sessions.create(:word_list_id => word_lists(:one).id)
    u.current_practice_session.student_responses.create(
      :user_id => u.id,
      :word => list_items(:speech).word,
      :word_id => list_items(:speech).id,
      :student_response => list_items(:speech).word)

#    puts "responses: " + u.current_practice_session.student_responses.to_s

    li = list_items(:each).next_word_not_yet_answered_correctly(u.id)
    assert_equal list_items(:hitch), li, "Didn't skip correct word"
  end

  test "next when all words are correct" do
    u = User.create
    ps = u.practice_sessions.create(:word_list_id => word_lists(:one).id)

    word_lists(:one).list_items.all.each do |li|
      ps.student_responses.create(
        :user_id => u.id,
        :word => li.word,
        :word_id => li.id,
        :student_response => li.word)
    end
    
    li = list_items(:watch).next_word_not_yet_answered_correctly(u.id)
    assert_equal list_items(:each), li, "Didn't go to next word"
  end
  
end
