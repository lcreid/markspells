require 'test_helper'

class WordListsControllerTest < ActionController::TestCase
  test "get the list of word lists as an anonymous user" do
    get :index
    assert_response :success

    assert_select( 'div#word-list-list', nil, "Missing word list") do
      assert_select( 'table#word-list', nil, "Missing word list table") do
        assert_select 'tr' do |row|
          assert_select row[0], 'td' do |col|
            assert_select col[1], 'td' do
            	assert_select 'a', 'Practice', "Missing Practice link"
            end
          end
        end
      end
    end
  end

end
