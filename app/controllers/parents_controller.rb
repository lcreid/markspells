class ParentsController < ApplicationController
  before_filter :authenticate_user!

  def show
    render :text => 'Internal error: missing id', :status => 500 and return unless params[:id]
    @user = User.find(params[:id])
  end
end
