require 'test_helper'

class ConfirmationsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test "should get show" do
    request.env['devise.mapping'] = Devise.mappings[:user]
    user = User.create( :email => "test_confirmation@example.com" )
    user.save!
#    puts "'#{user.confirmation_token}'"
    get :show, :confirmation_token => user.confirmation_token
    assert_response :success
  end

  test "confirm" do
    request.env['devise.mapping'] = Devise.mappings[:user]
    user = User.create( :email => "test_confirmation@example.com" )
    user.save!

    params = {
      :user => {
        :password => "123456",
        :password_confirmation => "123456",
        :confirmation_token => user.confirmation_token
      }
    }
    put :confirm, params
    assert_redirected_to :root
  end
end
