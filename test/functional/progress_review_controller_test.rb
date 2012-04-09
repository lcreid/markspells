require 'test_helper'

class ProgressReviewControllerTest < ActionController::TestCase
  test "should fail to get cuadrant" do
    # get on this always needs to know the results we're working on,
    # so this has to fail
    get :cuadrant
    assert_response :error
  end
  
  test "basic test four cuadrants" do
    get :cuadrant, :criteria => {:word_list_id => word_lists(:basic_cuadrant_test)}
    assert_response :success
    
    assert_select 'div#cuadrant-wrapper', nil, "Missing cuadrant-wrapper" do
      assert_select 'div#green-cuadrant', nil, "Missing green-cuadrant" do
        assert_select 'a.student' do |g|
          assert_match /.*Cathy Green.*/, g[0].to_s, "Missing or wrong green student"
          assert_match /.*Marc Green.*/, g[1].to_s, "Missing or wrong green student"
        end
      end
      assert_select 'div#orange-cuadrant', nil, "Missing orange-cuadrant"
      assert_select 'div#yellow-cuadrant', nil, "Missing yellow-cuadrant"
      assert_select 'div#red-cuadrant', nil, "Missing red-cuadrant"
    end
  end

end
