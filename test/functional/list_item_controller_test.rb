require 'test_helper'

class ListItemControllerTest < ActionController::TestCase
  test "should get practice first word" do
    get :practice
    assert_response :success

	 assert_select 'div#messages', "", "Missing or wrong messages"
	 assert_select 'div#word-test', nil, "Missing test"
	 assert_select 'div#beginning-of-sentence', "Try to spell", "Missing or wrong sentence beginning"
	 assert_select 'div#student-response-word', nil, "Missing or wrong student response word"
	 assert_select 'div#end-of-sentence', "word as best you can.", "Missing or wrong sentence end"
	 assert_select 'div#links', nil, "Missing links"

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

  test "should get practice arbitrary word" do
    get :practice, :id => list_items(:pouch).id
    assert_response :success
  end

  test "word spelled correctly" do
    post :check, :word_id => list_items(:pouch).id, :word => list_items(:pouch).word, :student_response => "Pouch"
    assert_redirected_to practice_list_item_path(list_items(:pouch).next)
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

end
