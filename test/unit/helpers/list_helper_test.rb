require 'test_helper'

class ListHelperTest < ActionView::TestCase
	test "results" do
		ls = ListStats.new
		assert_equal 20, ls.total_words, "Total words"
		assert_equal 0, ls.words_correct, "Words correct"
		assert_equal 20, ls.words_untried, "Words untried"
		assert_equal 20, ls.words_left, "Words left"
		
		# Response is correct
		r = StudentResponse.new
		r.word = list_items(:each).word
		r.student_response = list_items(:each).word
		r.save # TODO: Should the model save itself? Should the stats depend on the database?
		assert_equal 20, ls.total_words, "Total words"
		assert_equal 1, ls.words_correct, "Words correct"
		assert_equal 19, ls.words_untried, "Words untried"
		assert_equal 19, ls.words_left, "Words left"
		
		# Response is wrong for new word
		r = StudentResponse.new
		r.word = list_items(:speech).word
		r.student_response = "speach"
		r.save # TODO: Should the model save itself? Should the stats depend on the database?
		assert_equal 20, ls.total_words, "Total words"
		assert_equal 1, ls.words_correct, "Words correct"
		assert_equal 18, ls.words_untried, "Words untried"
		assert_equal 19, ls.words_left, "Words left"
		
		# Response is correct for previously wrong word
		r = StudentResponse.new
		r.word = list_items(:speech).word
		r.student_response = "speech"
		r.save # TODO: Should the model save itself? Should the stats depend on the database?
		assert_equal 20, ls.total_words, "Total words"
		assert_equal 2, ls.words_correct, "Words correct"
		assert_equal 18, ls.words_untried, "Words untried"
		assert_equal 18, ls.words_left, "Words left"
		
		# Previously spelled correctly is correct again
		r = StudentResponse.new
		r.word = list_items(:each).word
		r.student_response = list_items(:each).word
		r.save # TODO: Should the model save itself? Should the stats depend on the database?
		assert_equal 20, ls.total_words, "Total words"
		assert_equal 2, ls.words_correct, "Words correct"
		assert_equal 18, ls.words_untried, "Words untried"
		assert_equal 18, ls.words_left, "Words left"
		
	end
	
end
