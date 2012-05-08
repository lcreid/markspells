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
    redirect_to parent_path(current_user) and return if user_signed_in? && ! current_user.children.empty?
    redirect_to student_path(current_user) and return if user_signed_in?
  end
end
