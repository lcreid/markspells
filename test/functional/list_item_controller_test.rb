require 'test_helper'

class ListItemControllerTest < ActionController::TestCase
  test "should get practice first word" do
    get :practice, :id => list_items(:each).id
    assert_response :success

    assert_select 'div#messages', "", "Missing or wrong messages"
    assert_select 'div#errors', "", "Missing or wrong messages"
    assert_select 'div#word-test', nil, "Missing test"
    assert_select 'object#dewplayer', nil, "Missing mp3 player"
    assert_select 'div#beginning-of-sentence', "Try to spell", "Missing or wrong sentence beginning"
    assert_select 'div#student-response-word', nil, "Missing or wrong student response word"
    assert_select 'div#end-of-sentence', "word as best you can.", "Missing or wrong sentence end"
    assert_select 'div#links input', nil, "Selector doesn't work"
    assert_select 'div#links' do
      assert_select 'input', nil, "Missing submit button"
      assert_select 'a', nil, "Missing skip link"
    end
    
    assert_select 'div#to-study', nil, "Missing study link div" do
    	assert_select 'a', "Study this list",  "Missing or incorrect study link."
    end
    
    assert_select 'div#to-all-lists', nil, "Missing all lists link div" do
    	assert_select 'a', "Back to all lists",  "Missing or incorrect all lists link."
    end

    assert_select 'div#stats' do
      assert_select 'form' do
        assert_select 'input', nil, 'Missing reset button'
      end
      assert_select 'table#stats' do
        assert_select 'tr' do |row|
          assert_select row[0], 'td' do |col|
            assert_select col[0], 'td', "Words in list"
            assert_select col[1], 'td', "20"
          end
          assert_select row[1], 'td' do |col|
            assert_select col[0], 'td', "Words correct"
            assert_select col[1], 'td', "0"
          end
          assert_select row[2], 'td' do |col|
            assert_select col[0], 'td', "Words untried"
            assert_select col[1], 'td', "20"
          end
          assert_select row[3], 'td' do |col|
            assert_select col[0], 'td', "Words left"
            assert_select col[1], 'td', "20"
          end
        end
      end
    end
  end

  test "should get practice arbitrary word" do
    get :practice, :id => list_items(:pouch).id
    assert_response :success
  end

  test "word spelled correctly" do
    post :check, :word_id => list_items(:pouch).id, :word => list_items(:pouch).word, :student_response => "Pouch"
    assert_redirected_to practice_list_item_path(list_items(:pouch).next_word_not_yet_answered_correctly(@controller.current_user_id).id)
  end

  test "word spelled incorrectly" do
    post :check, :word_id => list_items(:pouch).id, :word => list_items(:pouch).word, :student_response => "Pooch"
    assert_redirected_to practice_list_item_path(list_items(:pouch).id)
  end

  test "last word in list spelled correctly" do
    post :check, :word_id => list_items(:watch).id, :word => list_items(:watch).word, :student_response => list_items(:watch).word
    assert_redirected_to practice_list_item_path(list_items(:each).id)
  end

  test "should get test" do
    get :test
    assert_response :success
  end

  test "Check that we get the same cookie for the duration" do
    @controller.current_user_id
    #		puts cookies[:current_user]
    #		puts "In the test case: " + @controller.current_user_id.to_s
    assert_no_difference '@controller.current_user_id', "Got a different user id" do
      get :practice, :id => list_items(:pouch).id
      assert_response :success
    end
  end

end
