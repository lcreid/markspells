class WelcomeController < ApplicationController
  before_filter :redirect_if_signed_in
  
  def index
  end
  
  def for_teachers
  end
  
  def promo
  end
  
  private
  def redirect_if_signed_in
    redirect_to student_path(current_user) if user_signed_in?
  end
end
