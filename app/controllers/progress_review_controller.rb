class ProgressReviewController < ApplicationController
  def cuadrant
    # We expect a :criteria hash to tell us what to report on
    render :text => 'Internal error: missing criteria', :status => 500 and return unless params[:criteria]
    @green_list = StudentResponse.green_list(params[:criteria])
  end
end
