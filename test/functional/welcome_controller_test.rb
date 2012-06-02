require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  test "should get index" do
    get :index
    assert_response :success

    assert_select 'div#banner', nil, "Missing banner"

	assert_select 'table', nil, "Missing blurbs table" do
		assert_select 'tr', 2 do |row|
			assert_select row[0], 'td.blurb', 2 do |td|
				assert_select td[0], 'td#practice-blurb', nil, "Missing practice blurb." do
					assert_select 'h1.blurb-header', "Practice Spelling", "Missing or wrong practice header."
				end
				assert_select td[1], 'td#teachers-blurb', nil, "Missing teachers blurb." do
					assert_select 'h1.blurb-header', "For Teachers", "Missing or wrong teachers header."
				end
			end
			assert_select row[1], 'td.blurb', 2 do |td|
				assert_select td[0], 'td#sign-up', nil, "Missing sign up." do
					assert_select 'h1.blurb-header', "Not registered? Sign up here.", "Missing or wrong sign-up header."
					assert_select 'div#sign-up-partial', 1, "Missing sign-up-partial."
				end
				assert_select td[1], 'td#sign-in', nil, "Missing sign in." do
					assert_select 'h1.blurb-header', "Already registered? Sign in here.", "Missing or wrong sign-in header."
					assert_select 'div#sign-in-partial', 1, "Missing sign-in-partial."
				end
			end
			assert_select 'td.vertical-spacer', 2, "Missing one or more vertical spacers"
		end
	end

    assert_select 'div#ads', nil, "Missing ads"
  end

  test "should redirect to parent home page if logged in and has children" do 
    u = users(:juan_senior)
    sign_in u
    get :index
    assert_redirected_to parent_path(u)
  end
  
  test "should redirect to student home page if logged in and not other role" do 
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
