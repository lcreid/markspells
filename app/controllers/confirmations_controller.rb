  # From https://github.com/plataformatec/devise/wiki/How%20To:%20Email-only%20sign-up
class ConfirmationsController < Devise::ConfirmationsController
  def show
#    puts params.inspect
#    puts params[:confirmation_token]
#    puts "Bad News" unless params[:confirmation_token]
    render :text => 'Internal error: missing confirmation token', :status => 500 and return unless params[:confirmation_token]
    self.resource = resource_class.find_by_confirmation_token(params[:confirmation_token])
#    puts self.resource.inspect
    super if resource.confirmed?
#    puts "Past super"
  end

  def confirm
    self.resource = resource_class.find_by_confirmation_token(params[resource_name][:confirmation_token])
#    params[resource_name].delete(:confirmation_token)
    if resource.update_attributes(params[resource_name].except(:confirmation_token)) && resource.password_match?
      self.resource = resource_class.confirm_by_token(params[resource_name][:confirmation_token])
      set_flash_message :notice, :confirmed
      sign_in_and_redirect(resource_name, resource)
    else
      render :action => "show"
    end
  end
end
