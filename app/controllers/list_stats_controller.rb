class ListStatsController < ApplicationController
  include UserHelper

  def reset
  	ListHelper::ListStats.new(params[:user_id], params[:word_list_id]).reset
  	redirect_to :back
  end
end
