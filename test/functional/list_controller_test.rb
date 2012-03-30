require 'test_helper'

class ListControllerTest < ActionController::TestCase
	test "must specify a list" do
	  assert_raise(RuntimeError) do 
		  get :practice
	  end
	end
		
	test "practice a list" do
		get :practice, :id => word_lists(:two).id
		assert_redirected_to practice_list_item_path(ListItem.
		  where(:word_list_id => word_lists(:two).id).
		  first(:order => "word_order"))
	end
		
end
