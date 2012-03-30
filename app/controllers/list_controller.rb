require 'list_item'

class ListController < ApplicationController
  def practice
    raise "No list ID provided." unless params[:id]
		redirect_to(practice_list_item_path(ListItem.where(:word_list_id => params[:id]).first(:order => "word_order")))
	end

	def check
	end

  def test
  end
end
