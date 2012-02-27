require 'test_helper'

class ListItemControllerTest < ActionController::TestCase
  test "should get practice first word" do
    get :practice
    assert_response :success
	 assert_select 'div#messages', nil, "Missing messages"
	 assert_select 'div#word-test', nil, "Missing test"
	 assert_select 'div#sentence', nil, "Missing sentence"
	 assert_select 'div#links', nil, "Missing links"
	 assert_select 'div#stats', nil, "Missing stats"
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
