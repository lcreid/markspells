class ListStatsController < ApplicationController
  include UserHelper

  def reset
#  	ListStatsHelper::ListStats.new(params[:user_id], params[:word_list_id]).reset
  	ListStatsHelper::ListStats.new(current_user_id, params[:word_list_id]).reset
  	redirect_to :back
  end
end
