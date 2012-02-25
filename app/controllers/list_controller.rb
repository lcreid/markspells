require 'list_item'

class ListController < ApplicationController
  def practice
		redirect_to(practice_list_item_path(ListItem.first(:order => "word_order")))
	end

	def check
	end

  def test
  end
end
