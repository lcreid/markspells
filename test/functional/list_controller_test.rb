require 'test_helper'

class ListControllerTest < ActionController::TestCase
	test "start practice" do
		get :practice
		assert_redirected_to practice_list_item_path(ListItem.first(:order => "word_order"))
	end
		
end
