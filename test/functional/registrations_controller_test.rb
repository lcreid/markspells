require 'test_helper'

class RegistrationsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test "register form pre-alpha" do
    # The following is some sort of magic needed for tests that use devise controllers.
    request.env['devise.mapping'] = Devise.mappings[:user]
    get :new
    assert_response :success

    assert_select "div.ui-helper-hidden-accessible", 1, "Should not contain form before we're ready"
  end

	# SEND A CONFIRMATION E-MAIL FOR A NEW USER
	test "send confirmation e-mail" do
    request.env['devise.mapping'] = Devise.mappings[:user]
    assert_difference 'ActionMailer::Base.deliveries.count', 1 do
      params = {
        :user => {
          :email => "a@example.com",
          :password => "123456",
          :password_confirmation => "123456",
        }
      }
      post :create, params
    end
	end
end
