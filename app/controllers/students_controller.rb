class StudentsController < ApplicationController
  before_filter :authenticate_user!

  def show
    render :text => 'Internal error: missing id', :status => 500 and return unless params[:id]
#    lists = current_user.overdue_assignments
    @user = User.find(params[:id])
  end
end
