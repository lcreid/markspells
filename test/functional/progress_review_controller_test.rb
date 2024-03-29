require 'test_helper'

class ProgressReviewControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  test "cuadrant redirects if user no logged in" do
    get :cuadrant, :criteria => {:word_list_id => word_lists(:basic_cuadrant_test)}
    assert_redirected_to new_user_session_path
  end
  
  test "should fail to get cuadrant" do
    # get on this always needs to know the results we're working on,
    # so this has to fail
    sign_in users(:user_for_auth_tests_only)
    get :cuadrant
    assert_response :error
  end
  
  test "basic test four cuadrants" do
    sign_in users(:user_for_auth_tests_only)
    get :cuadrant, :criteria => {:word_list_id => word_lists(:basic_cuadrant_test)}
    assert_response :success
    
    assert_select 'div#cuadrant-wrapper', nil, "Missing cuadrant-wrapper" do
      assert_select 'div#green-cuadrant', nil, "Missing green-cuadrant" do
        assert_select 'a.student' do |g|
          assert g.detect { |x| x.to_s =~ /.*Cathy Green.*/ }, "Missing or wrong green student"
          assert g.detect { |x| x.to_s =~ /.*Marc Green.*/ }, "Missing or wrong green student"
        end
      end
      assert_select 'div#orange-cuadrant', nil, "Missing orange-cuadrant" do
        assert_select 'a.student' do |g|
          assert g.detect { |x| x.to_s =~ /.*Linda Orange.*/ }, "Missing or wrong green student"
        end
      end
      assert_select 'div#yellow-cuadrant', nil, "Missing yellow-cuadrant" do
        assert_select 'a.student' do |g|
          assert g.detect { |x| x.to_s =~ /.*Nicky Yellow.*/ }, "Missing or wrong green student"
        end
      end
      assert_select 'div#red-cuadrant', nil, "Missing red-cuadrant" do
        assert_select 'a.student' do |g|
          assert g.detect { |x| x.to_s =~ /.*Larry Red.*/ }, "Missing or wrong green student"
        end
      end
    end
  end

end
