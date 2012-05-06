require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  test "should get index" do
    get :index
    assert_response :success

    assert_select 'div#banner', nil, "Missing banner"

    assert_select 'table', nil, "Missing blurbs table" do
      assert_select 'td.blurb', 3 do |td|
        assert_select td[0], 'td#practice-blurb', nil, "Missing practice blurb." do
          assert_select 'h1.blurb-header', "Practice Spelling", "Missing or wrong practice header."
        end
        assert_select td[1], 'td#teachers-blurb', nil, "Missing teachers blurb." do
          assert_select 'h1.blurb-header', "For Teachers", "Missing or wrong teachers header."
        end
        assert_select td[2], 'td#sign-up', nil, "Missing sign-up blurb." do
          assert_select 'h1.blurb-header', "Sign Up", "Missing or wrong sign up header"
        end
      end
      assert_select 'td.vertical-spacer', 2, "Missing one or more vertical spacers"
    end

    assert_select 'div#bottom-ads', nil, "Missing bottom ads"
  end

  test "should redirect to user home page if logged in" do 
    u = users(:one_each)
    sign_in u
    get :index
    assert_redirected_to student_path(u)
  end
  
	test "should get teachers' page" do
    get :for_teachers
    assert_response :success
	end
	
	test "should get promo page" do
    get :promo
    assert_response :success
	end
	
	test "Check for nav bars" do
		get :index
		assert_response :success
		
		assert_select 'div#top-nav-bar', nil, "Missing top nav bar" do
			assert_select 'li', nil do |menu_item|
				assert_select menu_item[0], 'li', "Home", "Missing or wrong home menu"
				assert_select menu_item[1], 'li', "Lists", "Missing or wrong lists menu"
			end
		end
		assert_select 'div#bottom-nav-bar', nil, "Missing bottom nav bar"
	end
end
