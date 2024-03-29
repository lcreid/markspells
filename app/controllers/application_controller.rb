class ApplicationController < ActionController::Base
  protect_from_forgery
  layout "application"
#  
#  def redirector
#  	redirect_to params[:url]
#  end

  # Use this in controllers when you want to hide a link, e.g.
  # show a not found if an unauthorized user tries to go to the
  # admin pages.
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  # Another way to do it
  def render404
    render :file => File.join(Rails.root, 'public', '404.html'), :status => 404, :layout => false
    return true
  end
end
