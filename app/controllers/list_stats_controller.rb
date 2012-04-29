class ListStatsController < ApplicationController
  include OldUserHelper

  def reset
#  	ListStatsHelper::ListStats.new(params[:user_id], params[:word_list_id]).reset
    user = OldUser.find(old_current_user_id)
  	user.reset
  	redirect_to :back
  end
end
