class ProgressReviewController < ApplicationController
  before_filter :authenticate_user!

  # TODO: This action should really be put into different controllers in a more RESTful fashion.
  # TODO: For example, there should be one in the list that automatically do it for a list it.
  def cuadrant
    # We expect a :criteria hash to tell us what to report on
    render :text => 'Internal error: missing criteria', :status => 500 and return unless params[:criteria]
    @green_list = StudentResponse.green_list(params[:criteria])
    @orange_list = StudentResponse.orange_list(params[:criteria])
    @yellow_list = StudentResponse.yellow_list(params[:criteria])
    @red_list = StudentResponse.red_list(params[:criteria])
  end
end
