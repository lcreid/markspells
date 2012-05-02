require 'test_helper'

class RegistrationsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  test "register form pre-alpha" do
    # The following is some sort of magic needed for tests that use devise controllers.
    request.env['devise.mapping'] = Devise.mappings[:user]
    get :new
    assert_response :success
    
    assert_select "form", false, "Should not contain form before we're ready"
  end
end