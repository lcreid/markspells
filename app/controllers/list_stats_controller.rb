class ListStatsController < ApplicationController
  include UserHelper

  def reset
  	ListHelper::ListStats.new(current_user_id).reset
  	redirect_to :back
  end
end
