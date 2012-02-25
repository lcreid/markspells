require 'test_helper'

class ListItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
	test "next list_item" do
		assert_equal list_items(:speech), list_items(:each).next
	end
	
end
