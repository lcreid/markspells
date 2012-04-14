class ListStatsController < ApplicationController
  include UserHelper

  def reset
#  	ListStatsHelper::ListStats.new(params[:user_id], params[:word_list_id]).reset
    user = User.find(current_user_id)
  	user.current_practice_session.reset
  	redirect_to :back
  end
end
