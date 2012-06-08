class WelcomeController < ApplicationController
  before_filter :redirect_if_signed_in, :except => [ :attribution ]
  
  def index
  end
  
  def for_teachers
  end
  
  def promo
  end
  
  def attribution
  end
  
  private
  def redirect_if_signed_in
    redirect_to parent_path(current_user) and return if user_signed_in? && ! current_user.children.empty?
    redirect_to student_path(current_user) and return if user_signed_in?
  end
end
