class ListStatsController < ApplicationController
  include OldUserHelper
  before_filter :authenticate_user!

  def reset
#  	ListStatsHelper::ListStats.new(params[:user_id], params[:word_list_id]).reset
    user = current_user
  	user.reset
  	redirect_to :back
  end
end
